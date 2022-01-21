import admin from "firebase-admin"
import getImageColor from "../../functions/getImageColor"
import { cache } from "../../app"
import { Playlist } from "../../types"
import { Request, Response } from "express"

const db = admin.firestore()

export const PUT = async (req: Request, res: Response) => {
	const { info: newPlaylist, removed } = req.body as { info: Playlist; removed: string[] }
	const songsColl = db.collection("songs")

	if (Object.values(cache.importing).includes(newPlaylist.id)) {
		throw new Error("Cannot edit a playlist that is being imported...")
	}

	const snap = await db.collection("playlists").doc(newPlaylist.id).get()

	if (!snap.exists) {
		throw new Error("Document not found in database")
	}
	const oldPlaylist = snap.data() as Playlist

	const promises: Promise<any>[] = removed.map(async songId => {
		const snaps = await songsColl
			.where("playlistId", "==", newPlaylist.id)
			.where("songId", "==", songId)
			.get()

		if (!snaps.empty) {
			await songsColl.doc(snaps.docs[0]!.id).delete()
		}
	})

	if (oldPlaylist.cover !== newPlaylist.cover) {
		newPlaylist.colorHex = await getImageColor(newPlaylist.cover)
	}

	await db.collection("playlists").doc(newPlaylist.id).set(newPlaylist)

	await Promise.allSettled(promises)

	res.status(200).send({})
}
