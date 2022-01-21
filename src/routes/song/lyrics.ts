import { cache } from "../../app"
import { Request, Response } from "express"

export const GET = async (req: Request, res: Response) => {
	const [song] = await cache.genius_api.search(req.query.query as string)
	if (!song) throw new Error(`Could not find lyrics for this song`)

	const lyrics = await cache.genius_api.lyrics(song.result.id)
	const lines: string[] = []
	for (let i = 0, il = lyrics.length; i < il; i++) {
		const part = lyrics[i]
		lines.push(...part.content)
	}

	res.status(200).send(lines)
}
