import convertSong from "../../../functions/convertSong"
import { Request, Response } from "express"

export const GET = async (req: Request, res: Response) => {
	const { filename } = req.params
	const { quality: quality_ } = req.query

	if (!["highest", "lowest"].includes((quality_ as string) || "")) {
		return res.status(400).send(`Cannot GET /song/${quality_}/${filename}`)
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename?.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		return convertSong(IDRegex[1]!, quality)
			.then(res.redirect.bind(res))
			.catch(err => res.status(400).send(err.message))
	} else {
		return res.status(400).send(`Cannot GET /song/${quality}/${filename}`)
	}
}
