import getImageColor from "./getImageColor"
import { AlbumDetailed, SongDetailed } from "ytmusic-api"
import { cache } from "../app"
import { DefaultEventsMap } from "socket.io/dist/typed-events"
import { Playlist, Song } from "../types"
import { Server } from "socket.io"

/**
 * Endpoint to search the API for song results
 */
export default async (
	IO: Server<DefaultEventsMap, DefaultEventsMap, DefaultEventsMap>,
	isInactive: () => boolean,
	query: string
) => {
	const transformAlbum = (albumDetailed: AlbumDetailed): Promise<Playlist> => {
		return new Promise<Playlist>(async (resolve, reject) => {
			if (isInactive()) return reject(null)

			const playlist: Playlist = {
				type: "Playlist",
				id: albumDetailed.albumId,
				name: albumDetailed.name,
				cover: albumDetailed.thumbnails.at(-1)?.url || "",
				userId: "",
				colorHex: await getImageColor(albumDetailed.thumbnails.at(-1)?.url || ""),
				order: (await cache.ytmusic_api.getPlaylistVideos(albumDetailed.playlistId)).map(
					t => t.videoId || ""
				)
			}

			IO.emit(`search_result_${query}`, playlist)
			resolve(playlist)
		})
	}

	const transformSong = (songDetailed: SongDetailed): Promise<Song> => {
		return new Promise<Song>(async (resolve, reject) => {
			if (isInactive()) return reject(null)

			const song: Song = {
				type: "Song",
				songId: songDetailed.videoId || "",
				title: songDetailed.name,
				artiste: songDetailed.artists.map(a => a.name).join(", "),
				cover: `https://i.ytimg.com/vi/${songDetailed.videoId}/maxresdefault.jpg`,
				colorHex: await getImageColor(
					`https://i.ytimg.com/vi/${songDetailed.videoId}/maxresdefault.jpg`
				),
				playlistId: "",
				userId: ""
			}

			IO.emit(`search_result_${query}`, song)
			resolve(song)
		})
	}

	if (!query) return IO.emit(`error_${query}`, "Missing query")
	IO.emit(`search_message_${query}`, "Waiting for YouTube...")

	const promises = [
		cache.ytmusic_api.search(query, "SONG"),
		cache.ytmusic_api.search(query, "ALBUM")
	] as const

	const results = await Promise.allSettled(promises)
	IO.emit(`search_message_${query}`, "Generating gradient backgrounds...")
	if (isInactive()) return undefined

	if (results.every(r => r.status === "fulfilled")) {
		const [songsDetailed, albumFull] = [
			(results[0] as PromiseFulfilledResult<SongDetailed[]>).value.slice(0, 5),
			(results[1] as PromiseFulfilledResult<AlbumDetailed[]>).value.slice(0, 15)
		]

		const promiseData = await Promise.allSettled([
			...songsDetailed.map(transformSong),
			...albumFull.map(transformAlbum)
		])
		const fulfilledData = promiseData.filter(
			r => r.status === "fulfilled"
		) as PromiseFulfilledResult<Song | Playlist>[]
		const transformedData = fulfilledData.map(r => r.value)

		if (isInactive()) return undefined
		return IO.emit(`search_done_${query}`, transformedData)
	} else {
		return IO.emit(`error_${query}`, "Error searching on server")
	}
}
