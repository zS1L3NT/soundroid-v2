import fs from "fs"
import { cache } from "../../../../app"
import { Request, Response } from "express"

export const GET = async (req: Request, res: Response) => {
	const { quality: quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_ || "")) {
		return res.status(400).send(`Cannot GET /ping/${quality_}/${filename}`)
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename?.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		if (fs.existsSync(cache.getSongPath(quality, filename!))) {
			return res.status(200).send()
		} else {
			return res.status(404).send()
		}
	} else {
		return res.status(400).send(`Cannot GET /ping/${quality}/${filename}`)
	}
}
