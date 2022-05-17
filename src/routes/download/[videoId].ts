import ytdl from "ytdl-core"

import { error, redirect } from "../../functions/responses"
import { RequestHandler } from "../../functions/withErrorHandling"

export const GET: RequestHandler = async req => {
	try {
		return redirect(
			(await ytdl.getInfo(req.params.videoId!)).formats
				.filter(f => f.container === "webm")
				.filter(f => f.mimeType?.startsWith("audio"))
				.filter(f => f.audioBitrate !== undefined)
				.sort((a, b) => b.audioBitrate! - a.audioBitrate!)
				.at(0)?.url!
		)
	} catch {
		return error("Cannot get download link for this video")
	}
}
