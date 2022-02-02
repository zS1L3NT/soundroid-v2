import assert from "assert"
import { cache, logger } from "../../app"
import { OBJECT, STRING, validate } from "validate-any"
import { RequestHandler } from "../../functions/withErrorHandling"

export const POST: RequestHandler = async req => {
	const { success, data, errors } = validate(req.body, OBJECT({ artistId: STRING() }))
	if (!success) {
		logger.warn(req.rid, `Invalid request body, returning 400`, req.body)
		return {
			status: 400,
			data: {
				errors
			}
		}
	}
	assert(data!)

	logger.log(req.rid, `Getting artist from artistId`, data.artistId)
	const artist = await cache.ytmusic_api.getArtist(data.artistId)
	return {
		status: 200,
		data: {
			artistId: artist.artistId,
			name: artist.name,
			thumbnail: artist.thumbnails.at(-1)?.url || "",
			description: artist.description || ""
		}
	}
}
