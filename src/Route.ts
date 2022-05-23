import { Request, Response } from "express"
import { validate } from "validate-any"
import Validator from "validate-any/dist/classes/Validator"

import logger from "./logger"

const queue: number[] = []

export type iRoute<T = any> = new (req: Request, res: Response) => Route<T>

export default abstract class Route<T = any> {
	constructor(protected readonly req: Request, protected readonly res: Response) {
		queue.push(queue.length === 0 ? 1 : queue.at(-1)! + 1)
		const rid = `{#${queue.at(-1)!}}`

		logger.http!(`Opening ${rid}`, this.req.method, this.req.url, this.req.body)

		if (this.validator) {
			const { success, errors } = validate(this.req.body, this.validator)
			if (!success) {
				this.res.status(400).send(errors)
				return
			}
		}

		this.handle()
			.catch(err => {
				logger.error(err)
				this.res.status(500).send(err)
			})
			.finally(() => {
				setTimeout(() => queue.splice(queue.indexOf(+rid.slice(2, -1)), 1), 60_000)

				logger.http!(`Closing ${rid}`, this.req.method, this.req.url, this.req.body)
			})
	}

	validator: Validator<T> | undefined

	abstract handle(): Promise<void>

	body(): T {
		return this.req.body as T
	}

	get query() {
		return this.req.query as Record<string, string>
	}

	get params() {
		return this.req.params as Record<string, string>
	}

	respond(data: any, status = 200) {
		this.res.send({
			data,
			status
		})
	}

	throw(message: string, status = 400) {
		this.res.send({
			data: {
				message
			},
			status
		})
	}

	redirect(url: string) {
		this.res.redirect(url)
	}
}
