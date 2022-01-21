import admin from "firebase-admin"
import getImageColor from "../../functions/getImageColor"
import { cache } from "../../app"
import { Playlist, Song } from "../../types"
import { Request, Response } from "express"

const db = admin.firestore()

export const POST = async (req: Request, res: Response) => {
	const { url, userId } = req.body as { url: string; userId: string }
	const link = new URL(url)
	let data: Playlist

	if (link.host === "open.spotify.com") {
		const playlistId = link.pathname.match(/^\/playlist\/(.*)/)?.[1]
		const albumId = link.pathname.match(/^\/album\/(.*)/)?.[1]
		const firestoreId = db.collection("playlists").doc().id

		const queries: [string, string][] = []
		if (!playlistId && !albumId) {
			throw new Error("Spotify URL does not reference a playlist")
		}

		if (cache.importing[userId]) {
			throw new Error("User is already importing a playlist!")
		}
		cache.importing[userId] = firestoreId

		if (playlistId) {
			const playlist = await cache.spotify_api.authenticated(() =>
				cache.spotify_api.api.getPlaylist(playlistId)
			)
			const tracks = playlist.tracks.items

			for (let i = 0; i < playlist.tracks.total; i += 100) {
				const playlist = await cache.spotify_api.authenticated(() =>
					cache.spotify_api.api.getPlaylistTracks(playlistId, { offset: i, limit: 100 })
				)
				const tracks = playlist.items
				for (let i = 0; i < tracks.length; i++) {
					const track = tracks[i]!.track
					queries.push([
						`${track?.name || ""} ${track?.artists[0]?.name || ""} ${
							track?.album?.name || ""
						}`,
						track?.album?.images?.[0]?.url || ""
					])
				}
			}

			data = {
				colorHex: await getImageColor(playlist.images[0]?.url || ""),
				cover: playlist.images[0]?.url || "",
				id: firestoreId,
				name: playlist.name,
				order: [],
				userId
			}
		}

		if (albumId) {
			const album = await cache.spotify_api.authenticated(() =>
				cache.spotify_api.api.getAlbum(albumId)
			)
			const cover = album?.images?.[0]?.url || ""
			const name = album?.name || ""

			for (let i = 0; i < album.tracks.total; i += 100) {
				const album = await cache.spotify_api.authenticated(() =>
					cache.spotify_api.api.getAlbumTracks(albumId, { offset: i, limit: 100 })
				)
				const tracks = album.items
				for (let i = 0; i < tracks.length; i++) {
					const track = tracks[i]
					queries.push([
						`${track?.name || ""} ${track?.artists[0]?.name || ""} ${name}`,
						cover
					])
				}
			}

			data = {
				colorHex: await getImageColor(album.images[0]?.url || ""),
				cover,
				id: firestoreId,
				name: album.name,
				order: [],
				userId
			}
		}

		await db.collection("playlists").doc(firestoreId).set(data!)
		res.status(200).send()

		const order: string[] = []
		for (const query of queries) {
			try {
				const results = await cache.ytmusic_api.search(query[0], "SONG")
				const data = results[0]
				if (!data) continue

				order.push(data.videoId || "")
				const song: Song = {
					artiste: data?.artists.map(a => a.name).join(", "),
					colorHex: await getImageColor(
						query[1] || `https://i.ytimg.com/vi/${data.videoId}/maxresdefault.jpg`
					),
					cover: query[1] || `https://i.ytimg.com/vi/${data.videoId}/maxresdefault.jpg`,
					playlistId: firestoreId,
					songId: data.videoId || "",
					title: data.name,
					userId
				}

				await db.collection("songs").add(song)
				await db.collection("playlists").doc(firestoreId).update({
					order
				})
			} catch (err) {
				// console.error(TAG, err)
			}
		}
	} else {
		throw new Error("URL does not reference a playlist")
	}
}
