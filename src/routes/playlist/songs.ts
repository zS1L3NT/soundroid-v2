import getImageColor from "../../functions/getImageColor"
import { cache } from "../../app"
import { Request, Response } from "express"
import { Song } from "../../types"

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
