import { ytmusic } from "../apis"
import { data } from "../functions/responses"
import { RequestHandler } from "../functions/withErrorHandling"

export const GET: RequestHandler = async req => {
	const query = req.query.query?.toString() || ""
	return data(
		(await Promise.all([ytmusic.searchSongs(query), ytmusic.searchAlbums(query)]))
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
										artistIds: result.artists.map(artist => artist.artistId),
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
										artistIds: result.artists.map(artist => artist.artistId),
										thumbnail: result.thumbnails.at(-1)?.url || ""
									}
								]
						  },
				{
					tracks: [] as Track[],
					albums: [] as Track[]
				}
			)
	)
}
