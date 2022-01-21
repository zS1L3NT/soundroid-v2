import admin from "firebase-admin"
import getImageColor from "../functions/getImageColor"
import { cache } from "../app"
import { Playlist, Song } from "../types"
import { Request, Response } from "express"
import { v4 } from "uuid"

const db = admin.firestore()

export const GET = async (req: Request, res: Response) => {
	const id = req.query.id as string
	if (!id) throw new Error("Missing Playlist ID")

	const album = await cache.ytmusic_api.getAlbum(id)
	const promises: Promise<Song>[] = []

	for (const track of album.songs) {
		const song: Promise<Song> = (async () => ({
			type: "Song",
			songId: track.videoId || "",
			title: track.name,
			artiste: track.artists.map(a => a.name).join(", "),
			cover: track.thumbnails.at(-1)?.url || "",
			colorHex: await getImageColor(track.thumbnails.at(-1)?.url || ""),
			playlistId: id,
			userId: ""
		}))()
		promises.push(song)
	}
	res.status(200).send(await Promise.all(promises))
}

export const POST = async (req: Request, res: Response) => {
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
