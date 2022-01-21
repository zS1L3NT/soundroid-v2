import admin from "firebase-admin"
import { cache } from "../../app"
import { Request, Response } from "express"

const db = admin.firestore()

export const DELETE = async (req: Request, res: Response) => {
	const playlistId = req.body.playlistId

	const playlistDoc = db.collection("playlists").doc(playlistId)
	const songsColl = db.collection("songs")

	const promises: Promise<any>[] = []

	if (Object.values(cache.importing).includes(playlistId)) {
		throw new Error("Cannot delete a playlist that is being imported...")
	}

	songsColl
		.where("playlistId", "==", playlistId)
		.get()
		.then(snaps =>
			snaps.forEach(snap => {
				promises.push(songsColl.doc(snap.id).delete())
			})
		)

	await Promise.allSettled(promises)
	await playlistDoc.delete()
	res.status(200).send({})
}
