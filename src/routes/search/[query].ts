import { ytmusic } from "../../apis"
import { RequestHandler } from "../../functions/withErrorHandling"

export const GET: RequestHandler = async req => {
	return {
		status: 200,
		data: (
			await Promise.all([
				ytmusic.searchSongs(req.params.query!),
				ytmusic.searchAlbums(req.params.query!)
			])
		)
			.flat()
			.reduce(
				(response, result) =>
					result.type === "SONG"
						? {
								...response,
								tracks: [
									...response.tracks,
									{
										id: result.videoId,
										title: result.name,
										artists: result.artists
											.map(artist => artist.name)
											.join(", "),
										thumbnail: result.thumbnails.at(-1)?.url || ""
									}
								]
						  }
						: {
								...response,
								albums: [
									...response.albums,
									{
										id: result.albumId,
										title: result.name,
										artists: result.artists
											.map(artist => artist.name)
											.join(", "),
										thumbnail: result.thumbnails.at(-1)?.url || ""
									}
								]
						  },
				{
					tracks: [] as Track[],
					albums: [] as Track[]
				}
			)
	}
}
