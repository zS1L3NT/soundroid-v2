import { cache, logger } from "../app"
import { Request, Response } from "express"

export type RequestHandler = (req: Request & { rid: string }) => Promise<
	| {
			status: number
			data: any
	  }
	| { redirect: string }
>

export default (handler: RequestHandler) => async (req: Request, res: Response) => {
	const rid = cache.generateRID()
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
	cache.clearRID(rid)
	logger.http!(`Closing ${rid}`, req.method, req.url, req.body)
}
