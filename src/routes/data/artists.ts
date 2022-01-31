import { cache } from "../../app"
import { Response } from "express"
import { LIST, OBJECT, OR, STRING, UNDEFINED, withValidBody } from "validate-any"
import { Artist } from "../../types"

export const POST = withValidBody(
	OBJECT({ trackId: OR(STRING(), UNDEFINED()), artistIds: OR(LIST(STRING()), UNDEFINED()) }),
	async (req, res: Response<Artist[] | { message: string }>) => {
		if (Object.keys(req.body).length !== 1) {
			return res.status(400).send({ message: "Invalid body" })
		}

		const artistIds: string[] = []

		if (req.body.artistIds) {
			artistIds.push(...req.body.artistIds)
		}

		if (req.body.trackId) {
			const track = await cache.ytmusic_api.getSong(req.body.trackId)
			artistIds.push(...track.artists.map(artist => artist.artistId || ""))
		}

		return res.status(200).send(
			await Promise.all(
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
		)
	}
)
