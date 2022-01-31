import getImageColor from "../../../functions/getImageColor"
import { cache } from "../../../app"
import { Request, Response } from "express"

export const GET = async (req: Request, res: Response) => {
	const track = await cache.ytmusic_api.getSong(req.params.id || "")
	res.status(200).send({
		trackId: track.videoId,
		title: track.name,
		thumbnail: track.thumbnails.at(-1)?.url || "",
		colorHex: await getImageColor(track.thumbnails.at(-1)?.url || "")
	})
}
