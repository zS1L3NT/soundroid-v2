import { NextFunction } from "express"

import { auth } from "../apis"
import { Middleware } from "../setup"

export default class extends Middleware {
	override async handle(next: NextFunction) {
		const [type, token] = (this.req.headers.authorization || "").split(" ")

		if (type !== "Bearer" || !token) {
			return this.throw("Unauthorized")
		}

		auth.verifyIdToken(token)
			.then(user => {
				//@ts-ignore
				this.req.userId = user.uid
				next()
			})
			.catch(() => this.throw("Unauthorized"))
	}
}
