import { NextFunction, Request, Response } from "express"
import { validate } from "validate-any"
import Validator from "validate-any/dist/classes/Validator"

import logger from "./logger"

const queue: number[] = []

export type iRoute = new (req: Request, res: Response) => Route

export abstract class Route<BV = {}, QV = {}> {
	constructor(protected readonly req: Request, protected readonly res: Response) {}

	setup() {
		queue.push(queue.length === 0 ? 1 : queue.at(-1)! + 1)
		const rid = `{#${queue.at(-1)!}}`

		logger.http!(`Opening ${rid}`, this.req.method, this.req.url, this.req.body)

		if (this.bodyValidator) {
			const { success, errors } = validate(this.req.body, this.bodyValidator)
			if (!success) {
				this.res.status(400).send({
					message: "Body Validation Errors",
					errors
				})
				return
			}
		}

		if (this.queryValidator) {
			const { success, errors } = validate(this.req.query, this.queryValidator)
			if (!success) {
				this.res.status(400).send({
					message: "Query Validation Errors",
					errors
				})
				return
			}
		}

		let handle = (next: () => Promise<void>) => next()
		
		for (const Middleware of this.middleware.reverse()) {
			handle = (next: () => Promise<void>) => new Middleware(this.req, this.res).handle(next)
		}

		handle(this.handle.bind(this))
			.catch(err => {
				logger.error(err)
				this.res.status(500).send(err)
			})
			.finally(() => {
				setTimeout(() => queue.splice(queue.indexOf(+rid.slice(2, -1)), 1), 60_000)

				logger.http!(`Closing ${rid}`, this.req.method, this.req.url, this.req.body)
			})
	}

	bodyValidator: Validator<BV> | undefined

	queryValidator: Validator<QV> | undefined

	middleware: iMiddleware[] = []

	abstract handle(): Promise<void>

	get body(): BV {
		return this.req.body as BV
	}

	get query(): QV {
		return this.req.query as unknown as QV
	}

	get params() {
		return this.req.params as Record<string, string>
	}

	respond(data: any, status = 200) {
		this.res.status(status).send(data)
	}

	throw(message: string, status = 400) {
		this.res.status(status).send({ message })
	}

	redirect(url: string) {
		this.res.redirect(url)
	}
}

export type iMiddleware = new (req: Request, res: Response) => Middleware

export abstract class Middleware {
	constructor(protected readonly req: Request, protected readonly res: Response) {}

	abstract handle(next: NextFunction): Promise<void>

	respond(data: any, status = 200) {
		this.res.status(status).send(data)
	}

	throw(message: string, status = 400) {
		this.res.status(status).send({ message })
	}

	redirect(url: string) {
		this.res.redirect(url)
	}
}
