import { OBJECT, STRING } from "validate-any"
import { ytmusic } from "../apis"
import { Route } from "../setup"

export class GET extends Route<any, { query: string }> {
	override queryValidator = OBJECT({
		query: STRING()
	})

	async handle() {
		this.respond(await ytmusic.getSearchSuggestions(this.query.query || ""))
	}
}
