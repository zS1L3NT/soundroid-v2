import https from "https"
import { OBJECT, STRING } from "validate-any"
import ytdl from "ytdl-core"

import { Route } from "../setup"

export class GET extends Route<any, { videoId: string }> {
	override queryValidator = OBJECT({
		videoId: STRING()
	})

	async handle() {
		const url = (await ytdl.getInfo(this.query.videoId)).formats
			.filter(f => f.container === "webm")
			.filter(f => f.mimeType?.startsWith("audio"))
			.filter(f => f.audioBitrate !== undefined)
			.sort((a, b) => b.audioBitrate! - a.audioBitrate!)
			.at(0)?.url!

		const req = https.get(url)

		req.once("response", async res => {
			let length = parseInt(res.headers["content-length"]!)
			if (!isNaN(length) && res.statusCode === 200) {
				this.respond(length + "")
			} else {
				this.throw("Could not get file size")
			}
		})

		req.once("error", e => this.throw(e.message))
	}
}
