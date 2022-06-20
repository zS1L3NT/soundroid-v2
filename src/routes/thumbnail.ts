import axios from "axios"
import sharp from "sharp"
import { OBJECT, STRING } from "validate-any"

import { Route } from "../setup"

export class GET extends Route<{}, { url: string }> {
	override queryValidator = OBJECT({
		url: STRING()
	})

	async handle() {
		const imageBuffer = (await axios.get(this.query.url, { responseType: "arraybuffer" })).data
		const resizedBuffer = await sharp(imageBuffer).resize(500, 500).toBuffer()

		this.res.writeHead(200, {
			"Content-Type": "image/png",
			"Content-Length": resizedBuffer.length
		})
		this.res.end(resizedBuffer)
	}
}
