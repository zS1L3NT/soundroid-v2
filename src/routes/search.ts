import { ytmusic } from "../apis"
import Route from "../Route"

export class GET extends Route {
	async handle() {
		const query = this.query.query?.toString() || ""

		const promises = await Promise.all([
			ytmusic.searchSongs(query),
			ytmusic.searchAlbums(query)
		])

		this.respond(
			promises.flat().reduce(
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
}
