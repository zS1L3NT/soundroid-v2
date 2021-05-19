import { Request, Response } from "express"
import { v4 } from "uuid"
import { convert_song } from "../all"

export default (req: Request, res: Response) => {
	const { quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_)) {
		return res.status(400).send(`Cannot GET /song/${quality_}/${filename}`)
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		const TAG = `convert_song_${quality}<${v4()}>:`
		console.time(TAG)

		convert_song(TAG, IDRegex[1], quality)
			.then(res.redirect.bind(res))
			.catch(err => res.status(400).send(err.message))
			.finally(() => console.timeEnd(TAG))
	}
	else {
		return res.status(400).send(`Cannot GET /song/${quality}/${filename}`)
	}
}
