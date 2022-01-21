import fs from "fs"
import ytdl from "ytdl-core"
import { cache } from "../app"

/**
 * Everytime a song gets starts the conversion, the server keeps track of all inbound requests that
 * occurred during the song conversion. Once the conversion is done, it will also handle those requests
 * that came earlier on and are waiting to be handled
 */
export default async (songId: string, quality: "highest" | "lowest") =>
	new Promise<string>(async (resolve, reject) => {
		if (!songId) return reject("Missing id")

		if (cache.converting[quality][songId]) {
			// Request came while song is converting
			cache.converting[quality][songId]!.push({ resolve, reject })
			return
		}

		const youtubeStream = ytdl(`https://youtu.be/${songId}`, {
			filter: "audioonly",
			quality
		}).on("error", () => {
			fs.unlinkSync(partPath)
			reject("Invalid YouTube ID")

			// Reject all other inbound requests
			cache.converting[quality][songId]?.forEach(p =>
				p.reject(`Error converting song on Server; Invalid YouTube ID`)
			)

			// Delete list of inbound requests
			delete cache.converting[quality][songId]
		})

		const partPath = cache.getPartPath(quality, songId)
		const songPath = cache.getSongPath(quality, songId)

		/**
		 * Streams the song data to a part file first, then moves the part file to the song file
		 */
		cache.converting[quality][songId] = []
		youtubeStream
			.pipe(fs.createWriteStream(partPath))
			.on("finish", () => {
				fs.renameSync(partPath, songPath)
				resolve(`/song/${quality}/${songId}.mp3`)

				// Resolve all other inbound requests
				cache.converting[quality][songId]?.forEach(p =>
					p.resolve(`/song/${quality}/${songId}.mp3`)
				)

				// Delete list of inbound requests
				delete cache.converting[quality][songId]
			})
			.on("error", () => {
				fs.unlinkSync(partPath)
				reject(`Error converting song on Server`)

				// Reject all other inbound requests
				cache.converting[quality][songId]?.forEach(p =>
					p.reject(`Error converting song on Server`)
				)

				// Delete list of inbound requests
				delete cache.converting[quality][songId]
			})
	})
