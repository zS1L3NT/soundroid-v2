import fs from "fs"
import { cache } from "../../../../app"
import { Request } from "express"
import { RequestHandler } from "../../../../functions/withErrorHandling"

export const GET: RequestHandler = async (req: Request) => {
	const { quality: quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_ || "")) {
		return {
			status: 400,
			data: `Cannot GET /ping/${quality_}/${filename}`
		}
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename?.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		if (fs.existsSync(cache.getSongPath(quality, filename!))) {
			return {
				status: 200,
				data: {}
			}
		} else {
			return {
				status: 404,
				data: {}
			}
		}
	} else {
		return {
			status: 400,
			data: `Cannot GET /ping/${quality}/${filename}`
		}
	}
}
