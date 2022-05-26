import { ytmusic } from "../apis"
import Route from "../Route"

export class GET extends Route {
	async handle() {
		this.respond(await ytmusic.getSearchSuggestions(this.query.query || ""))
	}
}
