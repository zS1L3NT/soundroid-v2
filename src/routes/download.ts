import axios from "axios"
import { OBJECT, STRING } from "validate-any"
import ytdl from "ytdl-core"

import logger from "../logger"
import { Route } from "../setup"

export class GET extends Route<any, { videoId: string }> {
	override queryValidator = OBJECT({
		videoId: STRING()
	})

	async handle() {
		try {
			const { formats } = await ytdl.getInfo(this.query.videoId)

			const allowedFormats = formats
				.filter(f => f.container === "webm")
				.filter(f => f.mimeType?.startsWith("audio"))
				.filter(f => f.audioBitrate !== undefined)
				.sort((a, b) => b.audioBitrate! - a.audioBitrate!)

			for (const format of allowedFormats) {
				try {
					await axios.get(format.url)
					return this.redirect(allowedFormats.at(0)?.url!)
				} catch {
					continue
				}
			}

			this.throw("No available audio formats", 404)
		} catch (err) {
			logger.error(err)
			this.throw("Cannot get download link for this video")
		}
	}
}
