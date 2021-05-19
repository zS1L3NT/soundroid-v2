import fs from "fs"
import path from "path"
import { v4 } from "uuid"
import { Request, Response } from "express"
import { convert_song } from "../all"

export default (req: Request, res: Response) => {
	const { quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_)) {
		return res.status(400).send(`Cannot GET /play/${quality_}/${filename}`)
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		if (
			fs.existsSync(path.join(__dirname, "..", "..", "song", quality, filename))
		) {
			return res.redirect(`/song/${quality}/${filename}`)
		}
		else if (
			fs.existsSync(path.join(__dirname, "..", "..", "part", quality, filename))
		) {
			return res.redirect(`/part/${quality}/${filename}`)
		}
		else {
			convert_song(
				`convert_song_${quality}<${v4()}>:`,
				IDRegex[1],
				quality
			)
			setTimeout(() => {
				res.redirect(`/part/${quality}/${filename}`)
			}, 3000)
		}
	}
	else {
		return res.status(400).send(`Cannot GET /play/${quality}/${filename}`)
	}
}

