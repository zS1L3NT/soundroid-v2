import { cache } from "../../app"
import { Response } from "express"
import { OBJECT, STRING, withValidBody } from "validate-any"
import { Artist } from "../../types"

export const POST = withValidBody(
	OBJECT({ artistId: STRING() }),
	async (req, res: Response<Artist>) => {
		const artist = await cache.ytmusic_api.getArtist(req.body.artistId)
		res.status(200).send({
			artistId: artist.artistId,
			name: artist.name,
			thumbnail: artist.thumbnails.at(-1)?.url || "",
			description: artist.description || ""
		})
	}
)
