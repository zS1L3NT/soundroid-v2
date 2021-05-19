import admin from "firebase-admin"
import { color_thief, Playlist, Song, Spotify } from "../all"

export default async (
	TAG: string,
	firestore: admin.firestore.Firestore,
	youtubeApi: any,
	body: any,
	importing: { [userId: string]: string },
	respond: () => void
) => {
	const { url, userId } = body as { url: string, userId: string }
	const link = new URL(url)
	const spotify = new Spotify()
	let data: Playlist

	if (link.host === "open.spotify.com") {
		const playlistId = link.pathname.match(/^\/playlist\/(.*)/)?.[1]
		const albumId = link.pathname.match(/^\/album\/(.*)/)?.[1]
		const firestoreId = firestore.collection("playlists").doc().id

		const queries: [string, string][] = []
		if (!playlistId && !albumId) {
			console.error(TAG, "Spotify URL does not reference a playlist")
			throw new Error("Spotify URL does not reference a playlist")
		}

		if (importing[userId]) {
			console.error("User is already importing a playlist!")
			throw new Error("User is already importing a playlist!")
		}
		importing[userId] = firestoreId

		if (playlistId) {
			console.log(TAG, "Spotify Playlist ID    : ", playlistId)
			const playlist = await spotify.getPlaylist(playlistId)
			const tracks = playlist.tracks.items
			console.log(TAG, "Spotify Playlist Tracks: ", tracks.length)

			for (let i = 0; i < playlist.tracks.total; i += 100) {
				const playlist = await spotify.getPlaylistTracks(playlistId, i)
				const tracks = playlist.items
				for (let i = 0; i < tracks.length; i++) {
					const track = tracks[i].track
					queries.push([
						`${track?.name || ""} ${track?.artists[0]?.name || ""} ${track?.album?.name || ""}`,
						track?.album?.images?.[0]?.url || ""
					])
				}
			}

			data = {
				colorHex: await color_thief(playlist.images[0]?.url || ""),
				cover: playlist.images[0]?.url || "",
				id: firestoreId,
				name: playlist.name,
				order: [],
				userId
			}
		}

		if (albumId) {
			console.log(TAG, "Spotify Album ID    : ", albumId)
			const album = await spotify.getAlbum(albumId)
			const cover = album?.images?.[0]?.url || ""
			const name = album?.name || ""
			console.log(TAG, "Spotify Album Tracks: ", album.tracks.total)

			for (let i = 0; i < album.tracks.total; i += 100) {
				const album = await spotify.getAlbumTracks(albumId, i)
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
				colorHex: await color_thief(album.images[0]?.url || ""),
				cover,
				id: firestoreId,
				name: album.name,
				order: [],
				userId
			}
		}

		await firestore
			.collection("playlists")
			.doc(firestoreId)
			.set(data!)
		respond()

		const order: string[] = []
		for (let i = 0; i < queries.length; i++) {
			const query = queries[i]
			try {
				const results = await youtubeApi.search(query[0], "song")
				const data = results.content[0]

				order.push(data.videoId)
				const song: Song = {
					artiste: data?.artist?.name || "",
					colorHex: await color_thief(query[1] || `https://i.ytimg.com/vi/${data.videoId}/maxresdefault.jpg`),
					cover: query[1] || `https://i.ytimg.com/vi/${data.videoId}/maxresdefault.jpg`,
					playlistId: firestoreId,
					songId: data.videoId,
					title: data.name,
					userId
				}

				console.log(TAG, `Song<${i}>: `, song.songId)

				await firestore.collection("songs").add(song)
				await firestore.collection("playlists").doc(firestoreId).update({
					order
				})
			} catch (err) {
				console.error(TAG, err)
			}
		}
	}
	else {
		console.error(TAG, "URL does not reference a playlist")
		throw new Error("URL does not reference a playlist")
	}
}