import { OBJECT, STRING } from "validate-any"
import ytdl from "ytdl-core"

import logger from "../logger"
import { Route } from "../setup"

export class GET extends Route<any, { videoId: string }> {
	override queryValidator = OBJECT({
		videoId: STRING()
	})

	async handle() {
		const stream = ytdl("https://youtu.be/" + this.query.videoId, {
			filter: "audioonly",
			quality: "highest"
		})

		this.res.setHeader(
			"Content-Disposition",
			`attachment; filename="${this.query.videoId}.webm"`
		)

		stream.pipe(this.res).on("error", err => {
			logger.error(err)
		})
	}
}
