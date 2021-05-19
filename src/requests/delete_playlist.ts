import admin from "firebase-admin"

export default async (
	TAG: string,
	firestore: admin.firestore.Firestore,
	playlistId: string,
	importing: { [userId: string]: string }
) => {
	const playlistDoc = firestore.collection("playlists").doc(playlistId)
	const songsColl = firestore.collection("songs")

	console.log(TAG, `Playlist`, playlistId)
	const promises: Promise<any>[] = []

	if (Object.values(importing).includes(playlistId)) {
		console.error(TAG, "Cannot delete a playlist that is being imported...")
		throw new Error("Cannot delete a playlist that is being imported...")
	}

	songsColl
		.where("playlistId", "==", playlistId)
		.get()
		.then(snaps => snaps.forEach(snap => {
			promises.push(songsColl.doc(snap.id).delete())
		}))

	await Promise.allSettled(promises)
	await playlistDoc.delete()
}