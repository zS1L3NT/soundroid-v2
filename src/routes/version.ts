import admin from "firebase-admin"
import { Request, Response } from "express"

export const GET = async (req: Request, res: Response) => {
	res.status(200).send((await admin.database().ref("/VERSION").get()).val())
}
