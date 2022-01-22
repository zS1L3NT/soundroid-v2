import admin from "firebase-admin"
import { Request, Response } from "express"

export const GET = async (req: Request, res: Response) => {
	const VERSION = (await admin.database().ref("/VERSION").get()).val()
	admin
		.storage()
		.bucket("gs://android-soundroid.appspot.com")
		.file(`soundroid-v${VERSION}.apk`)
		.getSignedUrl({
			action: "read",
			expires: Date.now() + 15 * 60 * 1000
		})
		.then(url => res.redirect(url[0]))
		.catch(() => res.status(400).send("APK doesn't exist on the server :O"))
}
