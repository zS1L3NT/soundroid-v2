import { Request, Response } from "express"

import logger from "../logger"

export type RequestHandler = (req: Request & { rid: string }) => Promise<
	| {
			status: number
			data: any
	  }
	| { redirect: string }
>

const queue: number[] = []

export default (handler: RequestHandler) => async (req: Request, res: Response) => {
	queue.push(queue.length === 0 ? 1 : queue.at(-1)! + 1)
	const rid = `{#${queue.at(-1)!}}`

	logger.http!(`Opening ${rid}`, req.method, req.url, req.body)
	try {
		const response = await handler(Object.assign(req, { rid }))
		if ("redirect" in response) {
			res.redirect(response.redirect)
		} else {
			res.status(response.status).send(response.data)
		}
	} catch (err) {
		logger.error(err)
		res.status(500).send(err)
	}

	setTimeout(() => {
		queue.splice(queue.indexOf(+rid.slice(2, -1)), 1)
	}, 60_000)

	logger.http!(`Closing ${rid}`, req.method, req.url, req.body)
}
