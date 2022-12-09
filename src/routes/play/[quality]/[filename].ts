import convertSong from "../../../functions/convertSong"
import fs from "fs"
import { cache } from "../../../app"
import { Request, Response } from "express"

export const GET = async (req: Request, res: Response) => {
	const { quality: quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_ || "")) {
		return res.status(400).send(`Cannot GET /play/${quality_}/${filename}`)
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename!.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		if (fs.existsSync(cache.getSongPath(quality, filename!))) {
			return res.redirect(`/song/${quality}/${filename}`)
		} else if (fs.existsSync(cache.getPartPath(quality, filename!))) {
			return res.redirect(`/part/${quality}/${filename}`)
		} else {
			convertSong(IDRegex[1]!, quality)
			setTimeout(() => res.redirect(`/part/${quality}/${filename}`), 3000)
		}
	} else {
		return res.status(400).send(`Cannot GET /play/${quality}/${filename}`)
	}
}
