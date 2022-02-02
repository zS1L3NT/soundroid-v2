import assert from "assert"
import convertSong from "../../../functions/convertSong"
import fs from "fs"
import { cache, logger } from "../../../app"
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

	if (fs.existsSync(cache.getTrackPath(trackId, quality))) {
		logger.log(filename, `File already converted, redirecting to track`)
		return {
			redirect: `/audio/track/${filename}`
		}
	} else {
		logger.log(filename, `File not converted yet, starting conversion process`)
		convertSong(trackId, quality)
		await new Promise(res => setTimeout(res, 3000))

		logger.log(filename, `Redirecting to partial`)
		return {
			redirect: `/audio/partial/${filename}`
		}
	}
}
