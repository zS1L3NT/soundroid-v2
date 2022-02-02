import assert from "assert"
import convertSong from "../../../functions/convertSong"
import { logger } from "../../../app"
import { Request } from "express"
import { RequestHandler } from "../../../functions/withErrorHandling"

export const GET: RequestHandler = async (req: Request) => {
	const { filename } = req.params
	assert(filename!)

	const match = filename.match(/^(.+)-(highest|lowest)\.mp3$/)
	if (!match) {
		logger.warn(filename, `Filename invalid, returning 400`)
		return {
			status: 400,
			data: {
				message: `Invalid filename: ${filename}`
			}
		}
	}

	const [, trackId, quality] = match as [string, string, "highest" | "lowest"]

	try {
		logger.info(filename, `Track conversion beginning`)
		const redirectUrl = await convertSong(trackId, quality)

		logger.info(filename, `Track converted, redirecting to track`)
		return {
			redirect: redirectUrl
		}
	} catch (err) {
		logger.error(`Error converting track`, err)
		return {
			status: 400,
			data: (err as Error).message
		}
	}
}
