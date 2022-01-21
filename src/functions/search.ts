import { color_thief, Playlist, Song } from "../all"
import { v4 } from "uuid"

/**
 * Endpoint to search the API for song results
 *
 * @param sendToClient
 * @param inactive
 * @param youtubeApi
 * @param args
 */
export default async (
	sendToClient: (event: string, tag: string, data) => void,
	inactive: () => boolean,
	youtubeApi,
	...args
) => {
	const [query] = args as string[]
	const TAG = `search<${v4()}>:`
	if (!query) return sendToClient("error", query, "Missing query")
	console.time(TAG)
	console.log(TAG, "Search: " + query)
	sendToClient("search_message", query, "Waiting for YouTube...")

	const destroy = () => {
		console.log(TAG, "disconnect")
		console.timeEnd(TAG)
	}

	console.time(TAG + " YouTube API Responded")
	Promise.allSettled([
		youtubeApi.search(query, "song"),
		youtubeApi.search(query, "album")
	]).then(async res => {
		console.timeEnd(TAG + " YouTube API Responded")
		sendToClient("search_message", query, "Generating gradient backgrounds...")
		if (inactive()) return destroy()
		if (res[0].status === "fulfilled" && res[1].status === "fulfilled") {
			const playlists_ = res[1].value.content.filter((a: any) => a.type === "album")
			const playlists = playlists_.slice(0, playlists_.length >= 5 ? 5 : playlists_.length)
			const songs_ = res[0].value.content
			const songs = songs_.slice(0, songs_.length >= 15 ? 15 : songs_.length)

			const results = await Promise.allSettled(promises(playlists, songs))
			const successResults = results.filter(result => result.status === "fulfilled") as PromiseFulfilledResult<Song | Playlist>[]
			const successValues = successResults.map(result => result.value)

			if (inactive()) return destroy()
			sendToClient("search_done", query, successValues)
		}
		else {
			console.error(TAG, JSON.stringify(res, null, 2))
			sendToClient("error", query, "Error searching on server")
		}
		console.timeEnd(TAG)
	})

	const promises: (playlists, songs) => (Promise<Song> | Promise<Playlist>)[] = (playlists, songs) =>
		[...playlists.map(playlist => playlistPromise(playlist)), ...songs.map(song => songPromise(song))]

	const playlistPromise = playlist => new Promise<Playlist>(async (resolve, reject) => {
		if (inactive()) return reject(null)
		const item: Playlist = {
			type: "Playlist",
			id: playlist.browseId,
			name: playlist.name,
			cover: playlist.thumbnails[playlist.thumbnails.length - 1].url,
			userId: "",
			colorHex: await color_thief(playlist.thumbnails[playlist.thumbnails.length - 1].url),
			order: (await youtubeApi.getAlbum(playlist.browseId)).tracks.map(track => track.videoId)
		}
		sendToClient("search_result", query, item)
		resolve(item)
	})

	const songPromise = song => new Promise<Song>(async (resolve, reject) => {
		if (inactive()) return reject(null)
		const item: Song = {
			type: "Song",
			songId: song.videoId,
			title: song.name,
			artiste: Array.isArray(song.artist) ? song.artist.map((a: any) => a.name).join(", ") : song.artist.name,
			cover: `https://i.ytimg.com/vi/${song.videoId}/maxresdefault.jpg`,
			colorHex: await color_thief(`https://i.ytimg.com/vi/${song.videoId}/maxresdefault.jpg`),
			playlistId: "",
			userId: ""
		}
		sendToClient("search_result", query, item)
		resolve(item)
	})
}