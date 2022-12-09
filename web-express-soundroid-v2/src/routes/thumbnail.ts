import axios from "axios"
import sharp from "sharp"
import { OBJECT, OR, STRING } from "validate-any"

import { ytmusic } from "../apis"
import processThumbnail from "../functions/processThumbnail"
import { Route } from "../setup"

export class GET extends Route<{}, { artistId: string } | { url: string }> {
	override queryValidator = OR(OBJECT({ artistId: STRING() }), OBJECT({ url: STRING() }))

	async handle() {
		const url =
			"url" in this.query
				? this.query.url
				: processThumbnail((await ytmusic.getArtist(this.query.artistId)).thumbnails.at(-1)?.url)
				
		const imageBuffer = (await axios.get(url, { responseType: "arraybuffer" })).data
		const resizedBuffer = await sharp(imageBuffer).resize(500, 500).toBuffer()

		this.res.writeHead(200, {
			"Content-Type": "image/png",
			"Content-Length": resizedBuffer.length
		})
		this.res.end(resizedBuffer)
	}
}
