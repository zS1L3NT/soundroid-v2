import { cache } from "../../../app"
import { Request, Response } from "express"

export const GET = async (req: Request, res: Response) => {
	const artist = await cache.ytmusic_api.getArtist(req.params.id || "")
	res.status(200).send({
		artistId: artist.artistId,
		name: artist.name,
		thumbnail: artist.thumbnails.at(-1)?.url || "",
		description: artist.description
	})
}
