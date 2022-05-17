import { ytmusic } from "../../apis"
import { data } from "../../functions/responses"
import { RequestHandler } from "../../functions/withErrorHandling"

export const GET: RequestHandler = async req =>
	data(
		(await ytmusic.getAlbum(req.params.id!)).songs.map(song => ({
			id: song.videoId,
			title: song.name,
			artists: song.artists.map(artist => artist.name).join(", "),
			thumbnail: song.thumbnails.at(-1)?.url || ""
		}))
	)
