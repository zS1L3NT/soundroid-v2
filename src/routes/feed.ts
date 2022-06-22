import { DocumentReference } from "firebase-admin/firestore"

import { listensColl, usersColl, ytmusic } from "../apis"
import processThumbnail from "../functions/processThumbnail"
import Artist from "../models/Artist"
import Track from "../models/Track"
import User from "../models/User"
import { Route } from "../setup"

export class GET extends Route {
	private userRef!: DocumentReference<User>
	private mostFrequentTrackIds: string[] = []

	async handle() {
		//@ts-ignore
		this.userRef = usersColl.doc("jnbZI9qOLtVsehqd6ICcw584ED93")
		this.mostFrequentTrackIds = Object.entries(
			(
				await listensColl
					.where("userRef", "==", this.userRef)
					.orderBy("timestamp", "desc")
					.limit(50)
					.get()
			).docs
				.map(doc => doc.data())
				.map(listen => listen.trackIds)
				.flat()
				.reduce<Record<string, number>>(
					(occ, trackId) => ({
						...occ,
						[trackId]: trackId in occ ? occ[trackId]! + 1 : 1
					}),
					{}
				)
		)
			.sort((a, b) => b[1] - a[1])
			.map(occurance => occurance[0])

		const response: any[] = []
		
		if (this.mostFrequentTrackIds.length < 20) {
			return this.respond(response)
		}

		const [mostListenedTracks, leastListenedTracks, recommendedTracks, mostListenedArtists] =
			await Promise.all([
				this.getMostListenedTracks(),
				this.getLeastListenedTracks(),
				this.getRecommendedTracks(),
				this.getMostListenedArtists()
			])

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

		if (mostListenedArtists[0]?.[1].length) {
			response.push({
				type: "artist",
				artist: mostListenedArtists[0][0],
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

		if (mostListenedArtists[1]?.[1].length) {
			response.push({
				type: "artist",
				artist: mostListenedArtists[1][0],
				items: mostListenedArtists[1][1]
			})
		}

		if (mostListenedArtists[2]?.[1].length) {
			response.push({
				type: "artist",
				artist: mostListenedArtists[2][0],
				items: mostListenedArtists[2][1]
			})
		}

		this.respond(response)
	}

	async getMostListenedTracks() {
		return (
			await Promise.all(
				this.mostFrequentTrackIds.slice(0, 10).map(ytmusic.getSong.bind(ytmusic))
			)
		).map(
			song =>
				new Track(
					song.videoId,
					song.name,
					song.artists.map(artist => ({
						id: artist.artistId,
						name: artist.name
					})),
					processThumbnail(song.thumbnails.at(-1)?.url)
				)
		)
	}

	async getLeastListenedTracks() {
		return (
			await Promise.all(
				this.mostFrequentTrackIds.reverse().slice(0, 10).map(ytmusic.getSong.bind(ytmusic))
			)
		).map(
			song =>
				new Track(
					song.videoId,
					song.name,
					song.artists.map(artist => ({
						id: artist.artistId,
						name: artist.name
					})),
					processThumbnail(song.thumbnails.at(-1)?.url)
				)
		)
	}

	async getRecommendedTracks() {
		return []
	}

	async getMostListenedArtists() {
		const items: [Artist, Promise<Track[]>][] = []

		const songs = await Promise.all(
			this.mostFrequentTrackIds.slice(0, 10).map(ytmusic.getSong.bind(ytmusic))
		)

		for (const song of songs) {
			if (items.length === 3) break

			const artistId = song.artists[0]?.artistId
			if (!artistId || items.find(item => item[0].id === artistId)) {
				continue
			}

			const artist = await ytmusic.getArtist(artistId)
			items.push([
				new Artist(artist.artistId, artist.name),
				ytmusic.getArtistSongs(artistId).then(songs =>
					songs
						.filter((song, i) => !this.mostFrequentTrackIds.includes(song.videoId))
						.slice(0, 15)
						.map(
							song =>
								new Track(
									song.videoId,
									song.name,
									song.artists.map(artist => ({
										id: artist.artistId,
										name: artist.name
									})),
									processThumbnail(song.thumbnails.at(-1)?.url)
								)
						)
				)
			])
		}

		return await Promise.all(
			items.map(async item => [item[0], await item[1]] as [Artist, Track[]])
		)
	}
}
