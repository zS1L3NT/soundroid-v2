import assert from "assert"
import fs from "fs"
import { cache } from "../../../app"
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

	if (fs.existsSync(cache.getTrackPath(trackId, quality))) {
		return {
			status: 200,
			data: {
				message: `Track has been converted`
			}
		}
	} else {
		return {
			status: 404,
			data: {
				message: `Track not converted`
			}
		}
	}
}
