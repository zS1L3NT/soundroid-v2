import { Request, Response } from "express"
import convertSong from "../../../functions/convertSong"

export const GET = async (req: Request, res: Response) => {
	const { quality: quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_ || "")) {
		return res.status(400).send(`Cannot GET /song/${quality_}/${filename}`)
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename!.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		convertSong(IDRegex[1], quality)
			.then(res.redirect.bind(res))
			.catch(err => res.status(400).send(err.message))
	} else {
		return res.status(400).send(`Cannot GET /song/${quality}/${filename}`)
	}
}
