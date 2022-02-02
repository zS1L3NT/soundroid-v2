import assert from "assert"
import { cache, logger } from "../../app"
import { LIST, OBJECT, OR, STRING, UNDEFINED, validate } from "validate-any"
import { Request } from "express"
import { RequestHandler } from "../../functions/withErrorHandling"

export const POST: RequestHandler = async (req: Request) => {
	const { success, data, errors } = validate(
		req.body,
		OBJECT({ trackId: OR(STRING(), UNDEFINED()), artistIds: OR(LIST(STRING()), UNDEFINED()) })
	)
	if (!success) {
		logger.warn(`Invalid request body, returning 400`, req.body)
		return {
			status: 400,
			data: {
				errors
			}
		}
	}
	assert(data!)

	if (Object.keys(data).length !== 1) {
		logger.warn(`Invalid request body, returning 400`, req.body)
		return {
			status: 400,
			data: {
				message: "Invalid body"
			}
		}
	}

	const artistIds: string[] = []

	if (data.artistIds) {
		artistIds.push(...data.artistIds)
		logger.log(`Getting artists from artistIds`, data.artistIds)
	}

	if (data.trackId) {
		const track = await cache.ytmusic_api.getSong(data.trackId)
		artistIds.push(...track.artists.map(artist => artist.artistId || ""))
		logger.log(`Getting artists from trackId`, data.trackId)
	}

	return {
		status: 200,
		data: await Promise.all(
			artistIds.map(async id => {
				const artist = await cache.ytmusic_api.getArtist(id)
				return {
					artistId: artist.artistId,
					name: artist.name,
					thumbnail: artist.thumbnails.at(-1)?.url || "",
					description: artist.description || ""
				}
			})
		)
	}
}
