import assert from "assert"
import convertSong from "../../../functions/convertSong"
import fs from "fs"
import { cache, logger } from "../../../app"
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

	if (fs.existsSync(cache.getTrackPath(trackId, quality))) {
		logger.log(req.rid, filename, `File already converted, redirecting to track`)
		return {
			redirect: `/audio/track/${filename}`
		}
	} else {
		logger.log(req.rid, filename, `File not converted yet, starting conversion process`)
		convertSong(trackId, quality, req.rid)
		await new Promise(res => setTimeout(res, 3000))

		logger.log(req.rid, filename, `Redirecting to partial`)
		return {
			redirect: `/audio/partial/${filename}`
		}
	}
}
