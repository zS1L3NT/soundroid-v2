import { Timestamp } from "firebase-admin/firestore"
import { OBJECT, STRING } from "validate-any"

import { searchesColl, usersColl, ytmusic } from "../apis"
import Search from "../models/Search"
import Track from "../models/Track"
import { Route } from "../setup"

export class GET extends Route<any, { query: string }> {
	override queryValidator = OBJECT({
		query: STRING()
	})

	async handle() {
		const query = `${this.query.query}`.trim() || ""

		const promises = await Promise.all([
			ytmusic.searchSongs(query),
			ytmusic.searchAlbums(query)
		])

		this.respond(
			promises.flat().reduce(
				(response, result) =>
					result.type === "SONG"
						? {
								...response,
								tracks: [
									...response.tracks,
									{
										id: result.videoId,
										title: result.name,
										artists: result.artists.map(artist => ({
											id: artist.artistId,
											name: artist.name
										})),
										thumbnail: (result.thumbnails.at(-1)?.url || "").replace(
											/w\d+-h\d+/,
											"w500-h500"
										)
									}
								]
						  }
						: {
								...response,
								albums: [
									...response.albums,
									{
										id: result.albumId,
										title: result.name,
										artists: result.artists.map(artist => ({
											id: artist.artistId,
											name: artist.name
										})),
										thumbnail: (result.thumbnails.at(-1)?.url || "").replace(
											/w\d+-h\d+/,
											"w500-h500"
										)
									}
								]
						  },
				{
					tracks: [] as Track[],
					albums: [] as Track[]
				}
			)
		)

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
