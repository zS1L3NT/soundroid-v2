import { OBJECT, STRING } from "validate-any"

import { ytmusic } from "../apis"
import { Route } from "../setup"

export class GET extends Route<any, { id: string }> {
	override queryValidator = OBJECT({
		id: STRING()
	})

	async handle() {
		this.respond(
			(await ytmusic.getAlbum(this.query.id)).songs.map(song => song.videoId).filter(Boolean)
		)
	}
}
