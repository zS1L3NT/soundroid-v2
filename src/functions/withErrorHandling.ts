import { Request, Response } from "express"

import logger from "../logger"
import { clearRID, generateRID } from "../RID"

export type RequestHandler = (req: Request & { rid: string }) => Promise<
	| {
			status: number
			data: any
	  }
	| { redirect: string }
>

export default (handler: RequestHandler) => async (req: Request, res: Response) => {
	const rid = generateRID()
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
	clearRID(rid)
	logger.http!(`Closing ${rid}`, req.method, req.url, req.body)
}
