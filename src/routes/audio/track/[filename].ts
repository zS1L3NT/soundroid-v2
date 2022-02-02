import assert from "assert"
import convertSong from "../../../functions/convertSong"
import { Request } from "express"
import { RequestHandler } from "../../../functions/withErrorHandling"

export const GET: RequestHandler = async (req: Request) => {
	const { filename } = req.params
	assert(filename!)

	const match = filename.match(/^(.+)-(highest|lowest)\.mp3$/)
	if (!match) {
		return {
			status: 400,
			data: {
				message: `Invalid filename: ${filename}`
			}
		}
	}

	const [, trackId, quality] = match as [string, string, "highest" | "lowest"]

	try {
		return {
			redirect: await convertSong(trackId, quality)
		}
	} catch (err) {
		return {
			status: 400,
			data: (err as Error).message
		}
	}
}
