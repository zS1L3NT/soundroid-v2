import admin from "firebase-admin"
import getImageColor from "../../functions/getImageColor"
import { Request, Response } from "express"
import { Song } from "../../types"

const db = admin.firestore()

export const PUT = async (req: Request, res: Response) => {
	const song = req.body as Song

	song.colorHex = await getImageColor(song.cover)

	const songRef = db.collection("songs")
	const snap = await songRef
		.where("songId", "==", song.songId)
		.where("playlistId", "==", song.playlistId)
		.get()

	if (snap.docs.length === 0) {
		throw new Error("Document not found in database")
	}

	await songRef.doc(snap.docs[0]!.id).set(song)
	res.status(200).send({})
}
