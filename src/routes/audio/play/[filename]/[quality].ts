import convertSong from "../../../../functions/convertSong"
import fs from "fs"
import { cache } from "../../../../app"
import { Request } from "express"
import { RequestHandler } from "../../../../functions/withErrorHandling"

export const GET: RequestHandler = async (req: Request) => {
	const { quality: quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_ || "")) {
		return {
			status: 400,
			data: `Cannot GET /play/${quality_}/${filename}`
		}
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename!.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		if (fs.existsSync(cache.getSongPath(quality, filename!))) {
			return {
				redirect: `/song/${quality}/${filename}`
			}
		} else if (fs.existsSync(cache.getPartPath(quality, filename!))) {
			return {
				redirect: `/part/${quality}/${filename}`
			}
		} else {
			convertSong(IDRegex[1]!, quality)
			await new Promise(res => setTimeout(res, 3000))
			return {
				redirect: `/part/${quality}/${filename}`
			}
		}
	} else {
		return {
			status: 400,
			data: `Cannot GET /play/${quality}/${filename}`
		}
	}
}
