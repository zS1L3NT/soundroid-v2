import { QueryDocumentSnapshot } from "firebase-admin/firestore"

import { listensColl, ytmusic } from "../apis"
import Artist from "../models/Artist"
import Listen from "../models/Listen"
import Track from "../models/Track"
import { Route } from "../setup"

export class GET extends Route {
	private userId = ""

	async handle() {
		//@ts-ignore
		this.userId = this.req.userId

		const [mostListenedTracks, leastListenedTracks, recommendedTracks, mostListenedArtists] =
			await Promise.all([
				this.getMostListenedTracks(),
				this.getLeastListenedTracks(),
				this.getRecommendedTracks(),
				this.getMostListenedArtists()
			])

		const response: any[] = []

		if (mostListenedArtists.length) {
			response.push({
				type: "track",
				title: "Tracks you listen to a lot",
				description: "A list of tracks that you've heard a lot recently",
				items: mostListenedTracks
			})
		}

		if (recommendedTracks.length) {
			response.push({
				type: "track",
				title: "Recommended for You",
				description: "A list of tracks we think you might like",
				items: recommendedTracks
			})
		}

		if (mostListenedArtists[0]) {
			response.push({
				type: "artist",
				artist: mostListenedArtists[0][0],
				description: "A list of artists that you've heard a lot recently",
				items: mostListenedArtists[0][1]
			})
		}

		if (leastListenedTracks.length) {
			response.push({
				type: "track",
				title: "Tracks you rarely listen to",
				description: "A list of tracks that you haven't been listening to",
				items: leastListenedTracks
			})
		}

		if (mostListenedArtists[1]) {
			response.push({
				type: "artist",
				artist: mostListenedArtists[1][0],
				description: "A list of artists that you've heard a lot recently",
				items: mostListenedArtists[1][1]
			})
		}

		if (mostListenedArtists[2]) {
			response.push({
				type: "artist",
				artist: mostListenedArtists[2][0],
				description: "A list of artists that you've heard a lot recently",
				items: mostListenedArtists[2][1]
			})
		}

		this.respond(response)
	}

	async getMostListenedTracks() {
		const snaps = await listensColl
			.where("userId", "==", this.userId)
			.orderBy("count", "desc")
			.limit(10)
			.get()
		const trackIds = snaps.docs.map(doc => doc.data().trackId)

		const songs = await Promise.all(trackIds.map(ytmusic.getSong.bind(ytmusic)))
		return songs.map(
			song =>
				new Track(
					song.videoId,
					song.name,
					song.artists.map(artist => artist.artistId),
					song.thumbnails.at(-1)?.url || ""
				)
		)
	}

	async getLeastListenedTracks() {
		const snaps = await listensColl
			.where("userId", "==", this.userId)
			.orderBy("count", "asc")
			.limit(10)
			.get()
		const trackIds = snaps.docs.map(doc => doc.data().trackId)

		const songs = await Promise.all(trackIds.map(ytmusic.getSong.bind(ytmusic)))
		return songs.map(
			song =>
				new Track(
					song.videoId,
					song.name,
					song.artists.map(artist => artist.artistId),
					song.thumbnails.at(-1)?.url || ""
				)
		)
	}

	async getRecommendedTracks() {
		return []
	}

	async getMostListenedArtists() {
		const items: [Artist, Promise<Track[]>][] = []
		let lastSnap: QueryDocumentSnapshot<Listen> | undefined

		while (true) {
			let query = listensColl
				.where("userId", "==", this.userId)
				.orderBy("count", "asc")
				.limit(10)
			if (lastSnap) query = query.startAfter(lastSnap)

			const snaps = await query.get()
			const trackIds = snaps.docs.map(doc => doc.data().trackId)

			if (trackIds.length === 0) break
			const songs = await Promise.all(trackIds.map(ytmusic.getSong.bind(ytmusic)))

			for (const song of songs) {
				if (items.length === 3) break

				const artistId = song.artists[0]?.artistId
				if (!artistId || items.find(item => item[0].id === artistId)) {
					continue
				}

				const artist = await ytmusic.getArtist(artistId)
				items.push([
					new Artist(artist.artistId, artist.name, artist.thumbnails.at(-1)?.url || ""),
					ytmusic.getArtistSongs(artistId).then(songs =>
						songs.map(
							song =>
								new Track(
									song.videoId,
									song.name,
									song.artists.map(artist => artist.artistId),
									song.thumbnails.at(-1)?.url || ""
								)
						)
					)
				])
			}

			if (items.length === 3) break
			//@ts-ignore
			lastSnap = snaps.docs.at(-1)!
			continue
		}

		return await Promise.all(
			items.map(async item => [item[0], await item[1]] as [Artist, Track[]])
		)
	}
}
