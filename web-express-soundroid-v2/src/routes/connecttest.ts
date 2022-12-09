
import { Route } from "../setup"

export class GET extends Route {
	async handle() {
		this.respond("Connected!")
	}
}
