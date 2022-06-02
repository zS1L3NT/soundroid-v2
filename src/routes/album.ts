import { ytmusic } from "../apis"
import { Route } from "../setup"

export class GET extends Route {
	async handle() {
		this.respond(
			(await ytmusic.getAlbum(this.query.id)).songs.map(song => ({
				id: song.videoId,
				title: song.name,
				artists: song.artists.map(artist => ({
					id: artist.artistId,
					name: artist.name
				})),
				thumbnail: song.thumbnails.at(-1)?.url || ""
			}))
		)
	}
}
