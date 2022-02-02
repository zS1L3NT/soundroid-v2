import convertSong from "../../../../functions/convertSong"
import { Request } from "express"
import { RequestHandler } from "../../../../functions/withErrorHandling"

export const GET: RequestHandler = async (req: Request) => {
	const { quality: quality_, filename } = req.params

	if (!["highest", "lowest"].includes(quality_ || "")) {
		return {
			status: 400,
			data: `Cannot GET /song/${quality_}/${filename}`
		}
	}

	const quality = quality_ as "highest" | "lowest"
	const IDRegex = filename?.match(/^(.+)\.mp3$/)
	if (IDRegex) {
		try {
			return {
				redirect: await convertSong(IDRegex[1]!, quality)
			}
		} catch (err) {
			return {
				status: 400,
				data: (err as Error).message
			}
		}
	} else {
		return {
			status: 400,
			data: `Cannot GET /song/${quality}/${filename}`
		}
	}
}
