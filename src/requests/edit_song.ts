import admin from "firebase-admin"
import { color_thief, Song } from "../all"

export default async (TAG: string, firestore: admin.firestore.Firestore, body: any) => {
	const song = body as Song

	console.log(TAG, "Data", song)
	song.colorHex = await color_thief(song.cover)

	const songRef = firestore.collection("songs")
	const snap = await songRef
		.where("songId", "==", song.songId)
		.where("playlistId", "==", song.playlistId)
		.get()

	if (snap.docs.length === 0) {
		console.log(TAG, "Document not found in database")
		throw new Error("Document not found in database")
	}

	await songRef.doc(snap.docs[0].id).set(song)
}