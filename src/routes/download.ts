import ytdl from "ytdl-core"

import Route from "../Route"

export class GET extends Route {
	async handle() {
		try {
			this.redirect(
				(await ytdl.getInfo(this.query.videoId?.toString() || "")).formats
					.filter(f => f.container === "webm")
					.filter(f => f.mimeType?.startsWith("audio"))
					.filter(f => f.audioBitrate !== undefined)
					.sort((a, b) => b.audioBitrate! - a.audioBitrate!)
					.at(0)?.url!
			)
		} catch {
			this.throw("Cannot get download link for this video")
		}
	}
}
