import { ytmusic } from "../apis"
import { Route } from "../setup"

export class GET extends Route {
	async handle() {
		this.respond(await ytmusic.getSearchSuggestions(this.query.query || ""))
	}
}
