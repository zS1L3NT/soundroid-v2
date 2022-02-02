import fs from "fs"
import ytdl from "ytdl-core"
import { cache, logger } from "../app"

/**
 * Everytime a song gets starts the conversion, the server keeps track of all inbound requests that
 * occurred during the song conversion. Once the conversion is done, it will also handle those requests
 * that came earlier on and are waiting to be handled
 */
export default async (trackId: string, quality: "highest" | "lowest") =>
	new Promise<string>(async (resolve, reject) => {
		if (cache.converting[`${trackId}-${quality}`]) {
			// Request came while song is converting
			logger.info(`Track being converted, waiting conversion to finish...`)
			cache.converting[`${trackId}-${quality}`]!.push({ resolve, reject })
			return
		}

		const youtubeStream = ytdl(`https://youtu.be/${trackId}`, {
			filter: "audioonly",
			quality
		}).on("error", () => {
			fs.unlinkSync(partialPath)
			reject("Error converting song on Server; Invalid YouTube ID")
			logger.error(`Invalid YouTube ID`, trackId)

			// Reject all other inbound requests
			cache.converting[`${trackId}-${quality}`]?.forEach(p =>
				p.reject(`Error converting song on Server; Invalid YouTube ID`)
			)

			// Delete list of inbound requests
			delete cache.converting[`${trackId}-${quality}`]
		})

		const partialPath = cache.getPartialPath(trackId, quality)
		const trackPath = cache.getTrackPath(trackId, quality)

		/**
		 * Streams the song data to a part file first, then moves the part file to the song file
		 */
		cache.converting[`${trackId}-${quality}`] = []
		youtubeStream
			.pipe(fs.createWriteStream(partialPath))
			.on("finish", () => {
				fs.renameSync(partialPath, trackPath)
				resolve(`/audio/track/${trackId}-${quality}.mp3`)
				logger.info(`Track converted`, trackId)

				// Resolve all other inbound requests
				cache.converting[`${trackId}-${quality}`]?.forEach(p =>
					p.resolve(`/audio/track/${trackId}-${quality}.mp3`)
				)

				// Delete list of inbound requests
				delete cache.converting[`${trackId}-${quality}`]
			})
			.on("error", err => {
				fs.unlinkSync(partialPath)
				reject(`Error converting song on Server`)
				logger.error(`Error converting track`, err)

				// Reject all other inbound requests
				cache.converting[`${trackId}-${quality}`]?.forEach(p =>
					p.reject(`Error converting song on Server`)
				)

				// Delete list of inbound requests
				delete cache.converting[`${trackId}-${quality}`]
			})
	})
