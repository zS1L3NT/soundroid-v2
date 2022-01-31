import getImageColor from "../../functions/getImageColor"
import { cache } from "../../app"
import { Response } from "express"
import { OBJECT, STRING, withValidBody } from "validate-any"
import { Track } from "../../types"

export const GET = withValidBody(
	OBJECT({ trackId: STRING() }),
	async (req, res: Response<Track>) => {
		const track = await cache.ytmusic_api.getSong(req.body.trackId)
		res.status(200).send({
			trackId: track.videoId || "",
			title: track.name,
			thumbnail: track.thumbnails.at(-1)?.url || "",
			colorHex: await getImageColor(track.thumbnails.at(-1)?.url || "")
		})
	}
)
