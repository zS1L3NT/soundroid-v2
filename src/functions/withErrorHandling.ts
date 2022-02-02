import { logger } from "../app"
import { Request, Response } from "express"

export type RequestHandler = (req: Request) => Promise<
	| {
			status: number
			data: any
	  }
	| { redirect: string }
>

export default (handler: RequestHandler) => async (req: Request, res: Response) => {
	logger.http!("Opening", req.method, req.url, req.body)
	try {
		const response = await handler(req)
		if ("redirect" in response) {
			res.redirect(response.redirect)
		} else {
			res.status(response.status).send(response.data)
		}
	} catch (err) {
		logger.error(err)
		res.status(500).send(err)
	}
	logger.http!("Closing", req.method, req.url, req.body)
}
