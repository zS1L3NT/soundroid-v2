import { v4 } from "uuid"
import ffmpeg from "fluent-ffmpeg"
import path from "path"
import fs from "fs"
import ytdl from "ytdl-core"

const songWritePath = (id: string) =>
	path.join(__dirname, "..", "songs", id + ".mp3")
const tempWritePath = (id: string) =>
	path.join(__dirname, "..", "temps", id + ".mp3")

/**
 * Endpoint to convert or wait for a song
 *
 * @param {string} id ID of YouTube video
 */
export default async (
	sendToClient: (event: string, data: any) => void,
	SONG_URL: string,
	...args: any[]
) => {
	const TAG = "convert_song: " + v4()
	const id = args[0] as string
	if (!id) return sendToClient("error_" + id, "Missing id")
	console.time(TAG)
	console.log(TAG)

	// Check if request was sent by mistake
	if (fs.existsSync(songWritePath(id)) && !fs.existsSync(tempWritePath(id))) {
		console.log(TAG, `File exists, sending "${id}"`)
		console.timeEnd(TAG)
		return sendToClient("song_converted_" + id, `${SONG_URL}/${id}.mp3`)
	}

	let info: ytdl.videoInfo
	const url = "https://youtu.be/" + id
	try {
		console.log(TAG, "Fetching: " + id)
		info = await ytdl.getBasicInfo(url)
		console.log(TAG, "Found   : " + id)
	} catch (e) {
		console.error(TAG, "Invalid YouTube ID")
		console.timeEnd(TAG)
		return sendToClient("error_" + id, "Invalid YouTube ID")
	}

	const totalSeconds = parseInt(info.videoDetails.lengthSeconds)
	sendToClient("song_downloading_" + id, totalSeconds)

	if (fs.existsSync(tempWritePath(id))) {
		console.log(TAG, "File being created, waiting for callback...")
		console.timeEnd(TAG)
		return
	}

	const youtubeStream = ytdl(url, {
		filter: "audioonly",
		quality: "highest"
	})

	console.log(TAG, "File creating...")
	ffmpeg(youtubeStream)
		.audioBitrate(info.formats[0].bitrate!)
		.withAudioCodec("libmp3lame")
		.toFormat("mp3")
		.saveToFile(tempWritePath(id))
		.on("end", () => {
			console.log(TAG, "File created, sending to all: " + id)
			console.timeEnd(TAG)
			fs.renameSync(tempWritePath(id), songWritePath(id))
			sendToClient("song_converted_" + id, `${SONG_URL}/${id}.mp3`)
		})
		.on("error", err => {
			console.error(TAG, err)
			console.timeEnd(TAG)
			sendToClient("error_" + id, `Error converting song on Server`)
		})
}
