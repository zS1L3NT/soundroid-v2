import { ytmusic } from "../apis"
import { Route } from "../setup"

export class GET extends Route {
	async handle() {
		const track = await ytmusic.getSong(this.query.id)
		this.respond({
			id: track.videoId,
			title: track.name,
			artists: track.artists.map(artist => ({
				id: artist.artistId,
				name: artist.name
			})),
			thumbnail: track.thumbnails.at(-1)?.url || ""
		})
	}
}
