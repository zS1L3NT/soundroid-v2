import assert from "assert"
import getImageColor from "../../functions/getImageColor"
import { cache } from "../../app"
import { OBJECT, STRING, validate } from "validate-any"
import { Request } from "express"
import { RequestHandler } from "../../functions/withErrorHandling"

export const POST: RequestHandler = async (req: Request) => {
	const { success, errors, data } = validate(req.body, OBJECT({ trackId: STRING() }))
	if (!success) {
		return {
			status: 400,
			data: {
				errors
			}
		}
	}
	assert(data!)

	const track = await cache.ytmusic_api.getSong(data.trackId)
	return {
		status: 200,
		data: {
			trackId: track.videoId || "",
			title: track.name,
			thumbnail: track.thumbnails.at(-1)?.url || "",
			colorHex: await getImageColor(track.thumbnails.at(-1)?.url || "")
		}
	}
}
