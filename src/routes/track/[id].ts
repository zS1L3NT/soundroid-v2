import { ytmusic } from "../../apis"
import Route from "../../Route"

export class GET extends Route {
	async handle() {
		const track = await ytmusic.getSong(this.params.id!)
		this.respond({
			id: track.videoId,
			title: track.name,
			artists: track.artists.map(artist => artist.name).join(", "),
			thumbnail: track.thumbnails.at(-1)?.url || ""
		})
	}
}
