import admin from "firebase-admin"
import getImageColor from "../../functions/getImageColor"
import { cache } from "../../app"
import { OBJECT, STRING, withValidBody } from "validate-any"
import { Playlist, Song } from "../../types.d"
import { Response } from "express"
import { useTryAsync } from "no-try"

const db = admin.firestore()

export const POST = withValidBody(
	OBJECT({ url: STRING(), userId: STRING() }),
	async (req, res: Response) => {
		const { url, userId } = req.body
		const link = new URL(url)
		let data: Playlist

		if (link.host !== "open.spotify.com")
			return res.status(400).send("URL does not reference a playlist")

		const playlistId = link.pathname.match(/^\/playlist\/(.*)/)?.[1]
		const albumId = link.pathname.match(/^\/album\/(.*)/)?.[1]
		const firestoreId = db.collection("playlists").doc().id

		if (!playlistId && !albumId)
			return res.status(400).send("Spotify URL does not reference a playlist")
		if (cache.importing[userId])
			return res.status(400).send("User is already importing a playlist!")
		cache.importing[userId] = firestoreId

		const queries: [string, string][] = []

		if (playlistId) {
			const playlist = await cache.spotify_api.authenticated(() =>
				cache.spotify_api.api.getPlaylist(playlistId)
			)

			for (let i = 0; i < playlist.tracks.total; i += 100) {
				const playlist = await cache.spotify_api.authenticated(() =>
					cache.spotify_api.api.getPlaylistTracks(playlistId, { offset: i, limit: 100 })
				)
				const tracks = playlist.items.map(t => t.track)
				for (const track of tracks) {
					queries.push([
						`${track.name || ""} ${track.artists[0]?.name || ""} ${
							track.album.name || ""
						}`,
						track.album.images[0]?.url || ""
					])
				}
			}

			data = {
				id: firestoreId,
				name: playlist.name,
				cover: playlist.images[0]?.url || "",
				colorHex: await getImageColor(playlist.images[0]?.url || ""),
				userId,
				order: []
			}
		}

		if (albumId) {
			const album = await cache.spotify_api.authenticated(() =>
				cache.spotify_api.api.getAlbum(albumId)
			)
			const cover = album.images[0]?.url || ""
			const name = album.name || ""

			for (let i = 0; i < album.tracks.total; i += 100) {
				const album = await cache.spotify_api.authenticated(() =>
					cache.spotify_api.api.getAlbumTracks(albumId, { offset: i, limit: 100 })
				)
				for (const track of album.items) {
					queries.push([
						`${track.name || ""} ${track.artists[0]?.name || ""} ${name}`,
						cover
					])
				}
			}

			data = {
				id: firestoreId,
				name: album.name,
				cover,
				colorHex: await getImageColor(album.images[0]?.url || ""),
				userId,
				order: []
			}
		}

		await db.collection("playlists").doc(firestoreId).set(data!)
		res.status(200).send()

		const order: string[] = []
		for (const query of queries) {
			await useTryAsync(async () => {
				const songDetailed = (await cache.ytmusic_api.search(query[0], "SONG"))[0]
				if (songDetailed) {
					order.push(songDetailed.videoId || "")
					const song: Song = {
						songId: songDetailed.videoId || "",
						title: songDetailed.name,
						artiste: songDetailed.artists.map(a => a.name).join(", "),
						cover:
							query[1] ||
							`https://i.ytimg.com/vi/${songDetailed.videoId}/maxresdefault.jpg`,
						colorHex: await getImageColor(
							query[1] ||
								`https://i.ytimg.com/vi/${songDetailed.videoId}/maxresdefault.jpg`
						),
						playlistId: firestoreId,
						userId
					}

					await db.collection("songs").add(song)
					await db.collection("playlists").doc(firestoreId).update({
						order
					})
				}
			})
		}

		return
	}
)
