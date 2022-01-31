import { Request, Response } from "express"
import { cache } from "../../app"

export const GET = async (req: Request, res: Response) => {
	return await cache.ytmusic_api.getArtist((req.query.id as string | undefined) || "")
}
