import { Request, Response } from "express"

export type RequestHandler = (req: Request) => Promise<
	| {
			status: number
			data: any
	  }
	| { redirect: string }
>

export default (handler: RequestHandler) => async (req: Request, res: Response) => {
	try {
		const response = await handler(req)
		if ("redirect" in response) {
			res.redirect(response.redirect)
		} else {
			res.status(response.status).send(response.data)
		}
	} catch (err) {
		console.error(err)
		res.status(500).send(err)
	}
}
