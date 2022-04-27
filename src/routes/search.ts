import { cache } from "../app"
import { RequestHandler } from "../functions/withErrorHandling"

export const GET: RequestHandler = async req => {
	const query = req.query.query as string
	if (!query) {
		return {
			status: 400,
			data: {
				message: "No query provided"
			}
		}
	}

	return {
		status: 200,
		data: await Promise.all(
			(
				await Promise.all([
					cache.ytmusic_api.searchSongs(query),
					cache.ytmusic_api.searchAlbums(query)
				])
			)
				.flat()
				.map(async result =>
					result.type === "SONG"
						? {
								type: "Song",
								songId: result.videoId || "",
								title: result.name,
								artiste: result.artists.map(a => a.name).join(", "),
								cover: `https://i.ytimg.com/vi/${result.videoId}/maxresdefault.jpg`,
								playlistId: "",
								userId: ""
						  }
						: {
								type: "Playlist",
								id: result.playlistId,
								name: result.name,
								cover: result.thumbnails.at(-1)?.url || "",
								userId: "",
								order: (
									await cache.ytmusic_api.getPlaylistVideos(result.playlistId)
								).map(t => t.videoId)
						  }
				)
		)
	}
}
