import assert from "assert"
import convertSong from "../../../functions/convertSong"
import { logger } from "../../../app"
import { RequestHandler } from "../../../functions/withErrorHandling"

export const GET: RequestHandler = async req => {
	const { filename } = req.params
	assert(filename!)

	const match = filename.match(/^(.+)-(highest|lowest)\.mp3$/)
	if (!match) {
		logger.warn(req.rid, filename, `Filename invalid, returning 400`)
		return {
			status: 400,
			data: {
				message: `Invalid filename: ${filename}`
			}
		}
	}

	const [, trackId, quality] = match as [string, string, "highest" | "lowest"]

	try {
		logger.info(req.rid, filename, `Track conversion beginning`)
		const redirectUrl = await convertSong(trackId, quality, req.rid)

		logger.info(req.rid, filename, `Track converted, redirecting to track`)
		return {
			redirect: redirectUrl
		}
	} catch (err) {
		logger.error(req.rid, `Error converting track`, err)
		return {
			status: 400,
			data: (err as Error).message
		}
	}
}
