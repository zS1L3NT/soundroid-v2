import { Request, Response } from "express"
import path from "path"
import fs from "fs"

export default (req: Request, res: Response) => {
	const { quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_)) {
		return res.status(400).send(`Cannot GET /ping/${quality_}/${filename}`)
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		if (fs.existsSync(path.join(__dirname, "..", "..", "song", quality, IDRegex[1] + ".mp3"))) {
			return res.status(200).send()
		}
		else {
			return res.status(404).send()
		}
	}
	else {
		return res.status(400).send(`Cannot GET /ping/${quality}/${filename}`)
	}
}