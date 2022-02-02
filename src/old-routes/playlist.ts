import admin from "firebase-admin"
import getImageColor from "../functions/getImageColor"
import { cache } from "../app"
import { LIST, OBJECT, OR, STRING, UNDEFINED, withValidBody } from "validate-any"
import { Playlist, Song } from "../types"
import { Request, Response } from "express"

const db = admin.firestore()

export const GET = async (req: Request, res: Response) => {
	const playlistId = req.query.id as string
	if (!playlistId) return res.status(400).send("Missing Playlist ID")

	const playlist = await cache.ytmusic_api.getPlaylistVideos(playlistId)
	const promises: Promise<Song>[] = []

	for (const track of playlist) {
		const song: Promise<Song> = (async () => ({
			type: "Song",
			songId: track.videoId || "",
			title: track.name,
			artiste: track.artists.map(a => a.name).join(", "),
			cover: track.thumbnails.at(-1)?.url || "",
			colorHex: await getImageColor(track.thumbnails.at(-1)?.url || ""),
			playlistId,
			userId: ""
		}))()
		promises.push(song)
	}

	return res.status(200).send(await Promise.all(promises))
}

export const POST = async (req: Request, res: Response) => {
	const playlist = req.body as Playlist

	const playlistColl = db.collection("playlists")
	const songsColl = db.collection("songs")
	const playlistDoc = playlistColl.doc()
	const promises: Promise<any>[] = []

	const songs = await cache.ytmusic_api.getPlaylistVideos(playlist.id)

	for (const song of songs) {
		promises.push(
			new Promise(async () =>
				songsColl.add({
					songId: song.videoId || "",
					title: song.name,
					artiste: song.artists.map(a => a.name).join(", "),
					cover: song.thumbnails.at(-1)?.url || "",
					colorHex: await getImageColor(song.thumbnails.at(-1)?.url || ""),
					playlistId: playlistDoc.id,
					userId: playlist.userId
				})
			)
		)
	}

	promises.push(
		playlistDoc.set({
			id: playlistDoc.id,
			name: playlist.name,
			cover: playlist.cover,
			colorHex: playlist.colorHex,
			userId: playlist.userId,
			order: songs.map(s => s.videoId)
		})
	)

	await Promise.allSettled(promises)
	res.status(200).send({})
}

export const PUT = withValidBody<{ playlist: Playlist; removed: string[] }, Request>(
	OBJECT({
		playlist: OBJECT({
			type: OR(STRING("Playlist"), UNDEFINED()),
			id: STRING(),
			name: STRING(),
			cover: STRING(),
			colorHex: STRING(),
			userId: STRING(),
			order: LIST(STRING())
		}),
		removed: LIST(STRING())
	}),
	async (req, res: Response) => {
		const { playlist: newPlaylist, removed } = req.body

		const songsColl = db.collection("songs")

		if (Object.values(cache.importing).includes(newPlaylist.id))
			return res.status(400).send("Cannot edit a playlist that is being imported...")

		const snap = await db.collection("playlists").doc(newPlaylist.id).get()
		if (!snap.exists) return res.status(400).send("Document not found in database")

		const oldPlaylist = snap.data() as Playlist
		const promises: Promise<any>[] = removed.map(async songId => {
			const snaps = await songsColl
				.where("playlistId", "==", newPlaylist.id)
				.where("songId", "==", songId)
				.get()

			if (!snaps.empty) await songsColl.doc(snaps.docs[0]!.id).delete()
		})

		if (oldPlaylist.cover !== newPlaylist.cover) {
			newPlaylist.colorHex = await getImageColor(newPlaylist.cover)
		}

		await db.collection("playlists").doc(newPlaylist.id).set(newPlaylist)
		await Promise.allSettled(promises)

		return res.status(200).send({})
	}
)

export const DELETE = withValidBody(
	OBJECT({ playlistId: STRING() }),
	async (req, res: Response) => {
		const { playlistId } = req.body

		const playlistDoc = db.collection("playlists").doc(playlistId)
		const songsColl = db.collection("songs")

		const promises: Promise<any>[] = []

		if (Object.values(cache.importing).includes(playlistId))
			return res.status(400).send("Cannot delete a playlist that is being imported...")

		songsColl
			.where("playlistId", "==", playlistId)
			.get()
			.then(snaps => snaps.forEach(snap => promises.push(songsColl.doc(snap.id).delete())))

		await Promise.allSettled(promises)
		await playlistDoc.delete()
		return res.status(200).send({})
	}
)
