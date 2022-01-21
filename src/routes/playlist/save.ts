import admin from "firebase-admin"
import { cache } from "../../app"
import { Playlist } from "../../types"
import { Request, Response } from "express"
import { v4 } from "uuid"

const db = admin.firestore()

export const PUT = async (req: Request, res: Response) => {
	const playlist = req.body as Playlist

	const songs = await playlist_songs(`playlist_songs<${v4()}>`, playlist.id, cache.ytmusic_api)

	const playlistColl = db.collection("playlists")
	const songsColl = db.collection("songs")
	const id = playlistColl.doc().id
	const playlistDoc = playlistColl.doc(id)
	const promises: Promise<any>[] = []

	for (let i = 0; i < songs.length; i++) {
		const song = songs[i]
		promises.push(
			songsColl.add({
				artiste: song.artiste,
				colorHex: song.colorHex,
				cover: song.cover,
				songId: song.songId,
				title: song.title,
				playlistId: id,
				userId: playlist.userId
			})
		)
	}
	promises.push(
		playlistDoc.set({
			colorHex: playlist.colorHex,
			cover: playlist.cover,
			id,
			name: playlist.name,
			userId: playlist.userId,
			order: songs.map(s => s.songId)
		} as Playlist)
	)

	await Promise.allSettled(promises)
	res.status(200).send({})
}
