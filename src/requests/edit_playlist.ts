import admin from "firebase-admin"
import { color_thief, Playlist } from "../all"

export default async (
	TAG: string,
	firestore: admin.firestore.Firestore,
	body: any,
	importing: { [userId: string]: string }
) => {
	const { info: newPlaylist, removed } = body as { info: Playlist, removed: string[] }
	const songsColl = firestore.collection("songs")

	console.log(TAG, "Data", newPlaylist)

	if (Object.values(importing).includes(newPlaylist.id)) {
		console.error(TAG, "Cannot edit a playlist that is being imported...")
		throw new Error("Cannot edit a playlist that is being imported...")
	}

	const snap = await firestore
		.collection("playlists")
		.doc(newPlaylist.id)
		.get()

	if (!snap.exists) {
		console.log(TAG, "Document not found in database")
		throw new Error("Document not found in database")
	}
	const oldPlaylist = snap.data() as Playlist

	const promises: Promise<any>[] = removed.map(async songId => {
		const snaps = await songsColl
			.where("playlistId", "==", newPlaylist.id)
			.where("songId", "==", songId)
			.get()

		if (!snaps.empty) {
			console.log(TAG, `Deleted song ${songId}`)
			await songsColl.doc(snaps.docs[0].id).delete()
		}
	})

	if (oldPlaylist.cover !== newPlaylist.cover) {
		newPlaylist.colorHex = await color_thief(newPlaylist.cover)
	}

	await firestore
		.collection("playlists")
		.doc(newPlaylist.id)
		.set(newPlaylist)

	await Promise.allSettled(promises)
}