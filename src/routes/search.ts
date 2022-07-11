import { Timestamp } from "firebase-admin/firestore"
import { OBJECT, STRING } from "validate-any"

import { searchesColl, usersColl, ytmusic } from "../apis"
import processThumbnail from "../functions/processThumbnail"
import IsAuthenticated from "../middleware/IsAuthenticated"
import Search from "../models/Search"
import { Route } from "../setup"

export class GET extends Route<any, { query: string }> {
	override queryValidator = OBJECT({
		query: STRING()
	})

	override middleware = [IsAuthenticated]

	async handle() {
		const query = `${this.query.query}`.trim() || ""
		//@ts-ignore
		const userRef = usersColl.doc(this.req.userId)

		const [songs, albums] = await Promise.all([
			ytmusic.searchSongs(query),
			ytmusic.searchAlbums(query)
		])

		this.respond({
			tracks: songs.map(song => ({
				id: song.videoId,
				title: song.name,
				artists: song.artists.map(artist => ({
					id: artist.artistId,
					name: artist.name
				})),
				thumbnail: processThumbnail(song.thumbnails.at(-1)?.url)
			})),
			albums: albums.map(album => ({
				id: album.albumId,
				title: album.name,
				artists: album.artists.map(artist => ({
					id: artist.artistId,
					name: artist.name
				})),
				thumbnail: processThumbnail(album.thumbnails.at(-1)?.url)
			}))
		})

		const snap = (
			await searchesColl.where("userRef", "==", userRef).where("query", "==", query).get()
		).docs[0]

		if (snap) {
			await snap.ref.update({ timestamp: Timestamp.now() })
		} else {
			await searchesColl.add(new Search(userRef, query, Timestamp.now()))
		}
	}
}
