import admin from "firebase-admin"
import getImageColor from "../functions/getImageColor"
import { OBJECT, OR, STRING, UNDEFINED, withValidBody } from "validate-any"
import { Request, Response } from "express"
import { Song } from "../types.d"

const db = admin.firestore()

export const PUT = withValidBody<Song, Request>(
	OBJECT({
		type: OR(STRING("Song"), UNDEFINED()),
		songId: STRING(),
		title: STRING(),
		artiste: STRING(),
		cover: STRING(),
		colorHex: STRING(),
		playlistId: STRING(),
		userId: STRING()
	}),
	async (req, res: Response) => {
		const song = req.body
		song.colorHex = await getImageColor(song.cover)

		const songRef = db.collection("songs")
		const snap = await songRef
			.where("songId", "==", song.songId)
			.where("playlistId", "==", song.playlistId)
			.get()

		if (snap.docs.length === 0) return res.status(400).send("Document not found in database")

		await songRef.doc(snap.docs[0]!.id).set(song)
		return res.status(200).send({})
	}
)
