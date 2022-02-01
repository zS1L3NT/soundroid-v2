import getImageColor from "../../functions/getImageColor"
import { cache } from "../../app"
import { Response } from "express"
import { LIST, OBJECT, OR, STRING, UNDEFINED, withValidBody } from "validate-any"
import { Track } from "../../types"

export const POST = withValidBody(
	OBJECT({ artistId: OR(STRING(), UNDEFINED()), trackIds: OR(LIST(STRING()), UNDEFINED()) }),
	async (req, res: Response<Track[] | { message: string }>) => {
		if (Object.keys(req.body).length !== 1) {
			return res.status(400).send({ message: "Invalid body" })
		}

		const trackIds: string[] = []

		if (req.body.trackIds) {
			trackIds.push(...req.body.trackIds)
		}

		if (req.body.artistId) {
			const artist = await cache.ytmusic_api.getArtist(req.body.artistId)
			trackIds.push(...artist.topSongs.map(song => song.videoId || ""))
		}

		return res.status(200).send(
			await Promise.all(
				trackIds.map(async id => {
					const track = await cache.ytmusic_api.getSong(id)
					return {
						trackId: track.videoId || "",
						title: track.name,
						thumbnail: track.thumbnails.at(-1)?.url || "",
						colorHex: await getImageColor(track.thumbnails.at(-1)?.url || "")
					}
				})
			)
		)
	}
)
