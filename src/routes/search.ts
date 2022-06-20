import { Timestamp } from "firebase-admin/firestore"
import { OBJECT, STRING } from "validate-any"

import { searchesColl, usersColl, ytmusic } from "../apis"
import processThumbnail from "../functions/processThumbnail"
import Search from "../models/Search"
import { Route } from "../setup"

export class GET extends Route<any, { query: string }> {
	override queryValidator = OBJECT({
		query: STRING()
	})

	async handle() {
		const query = `${this.query.query}`.trim() || ""

		const [songs, albums] = await Promise.all([
			ytmusic.searchSongs(query),
			ytmusic.searchAlbums(query)
		])

		this.respond({
			tracks: await Promise.all(
				songs.map(async song => ({
					id: song.videoId,
					title: song.name,
					artists: song.artists.map(artist => ({
						id: artist.artistId,
						name: artist.name
					})),
					thumbnail: await processThumbnail(song.thumbnails.at(-1)?.url)
				}))
			),
			albums: await Promise.all(
				albums.map(async album => ({
					id: album.albumId,
					title: album.name,
					artists: album.artists.map(artist => ({
						id: artist.artistId,
						name: artist.name
					})),
					thumbnail: await processThumbnail(album.thumbnails.at(-1)?.url)
				}))
			)
		})

		const snap = (
			await searchesColl
				.where("userRef", "==", usersColl.doc("jnbZI9qOLtVsehqd6ICcw584ED93"))
				.where("query", "==", query)
				.get()
		).docs[0]

		if (snap) {
			await snap.ref.update({ timestamp: Timestamp.now() })
		} else {
			await searchesColl.add(
				new Search(usersColl.doc("jnbZI9qOLtVsehqd6ICcw584ED93"), query, Timestamp.now())
			)
		}
	}
}
