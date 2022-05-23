import { ytmusic } from "../../apis"
import Route from "../../Route"

export class GET extends Route {
	async handle() {
		this.respond(
			(await ytmusic.getAlbum(this.params.id!)).songs.map(song => ({
				id: song.videoId,
				title: song.name,
				artists: song.artists.map(artist => artist.name).join(", "),
				thumbnail: song.thumbnails.at(-1)?.url || ""
			}))
		)
	}
}
