import path from "path"
import fs from "fs"
import ytdl from "ytdl-core"

type PromiseCallback = {
	resolve: (value: (PromiseLike<string> | string)) => void,
	reject: (reason?: any) => void
}

let converting: {
	highest: {
		[songId: string]: PromiseCallback[]
	},
	lowest: {
		[songId: string]: PromiseCallback[]
	}
} = {
	highest: {},
	lowest: {}
}

export default async (TAG: string, songId: string, quality: "highest" | "lowest") => new Promise<string>(async (resolve, reject) => {
	if (!songId) return reject("Missing id")

	console.log(TAG, `Song`, songId)

	if (converting[quality][songId]) {
		converting[quality][songId].push({ resolve, reject })
		console.log(TAG, "Converting already, waiting for file...")
		return
	}

	const youtubeStream = ytdl("https://youtu.be/" + songId, {
		filter: "audioonly",
		quality
	}).on("error", err => {
		fs.unlinkSync(partPath)
		console.error(TAG, err)
		reject("Invalid YouTube ID!")
		converting[quality][songId].forEach(p => p.reject(`Error converting song on Server`))
		delete converting[quality][songId]
	})

	const partPath = path.join(__dirname, "..", "..", "part", quality, songId + ".mp3")
	const songPath = path.join(__dirname, "..", "..", "song", quality, songId + ".mp3")

	console.log(TAG, "File creating...")
	converting[quality][songId] = []
	youtubeStream
		.pipe(fs.createWriteStream(partPath))
		.on("finish", () => {
			fs.renameSync(partPath, songPath)
			console.log(TAG, "Created File: " + songId)
			resolve(`/song/${quality}/${songId}.mp3`)
			converting[quality][songId].forEach(p => p.resolve(`/song/${quality}/${songId}.mp3`))
			delete converting[quality][songId]
		})
		.on("error", err => {
			fs.unlinkSync(partPath)
			console.error(TAG, err)
			reject(`Error converting song on Server`)
			converting[quality][songId].forEach(p => p.reject(`Error converting song on Server`))
			delete converting[quality][songId]
		})
})
