import express from "express"
import ffmpeg from "fluent-ffmpeg"
import path from "path"
import http from "http"
import admin from "firebase-admin"
import { Server } from "socket.io"
import { v4 } from "uuid"
import {
	default_playlists,
	delete_playlist,
	edit_playlist,
	edit_song,
	get_full_song,
	get_lyrics,
	get_ping_song,
	get_play_song,
	import_playlist,
	playlist_songs,
	save_playlist,
	search
} from "./all"

const GeniusApi = require("node-genius-api")
const YoutubeMusicApi = require("youtube-music-api")

const app = express()
const server = http.createServer(app)
const youtubeApi = new YoutubeMusicApi()
const genius = new GeniusApi(require("../config.json").genius)
const IO = new Server(server, {
	cors: {
		origin: "*"
	},
	pingTimeout: 60000,
	pingInterval: 300000
})
const PORT = 5190
ffmpeg.setFfmpegPath(require("@ffmpeg-installer/ffmpeg").path)
admin.initializeApp({
	credential: admin.credential.cert(require("../config.json").firebase.service_account),
	databaseURL: "https://android-soundroid-default-rtdb.asia-southeast1.firebasedatabase.app"
})

app.use(express.json())
app.set("view engine", "ejs")
app.set("views", path.join(__dirname, "views"))
app.use("/assets", express.static(path.join(__dirname, "assets")))
app.use("/part/highest", express.static(path.join(__dirname, "..", "part", "highest")))
app.use("/part/lowest", express.static(path.join(__dirname, "..", "part", "lowest")))
app.use("/song/highest", express.static(path.join(__dirname, "..", "song", "highest")))
app.use("/song/lowest", express.static(path.join(__dirname, "..", "song", "lowest")))

const importing: { [userId: string]: string } = {}

let VERSION = ""
admin.database().ref("/VERSION").on("value", snap => {
	if (snap.exists()) {
		VERSION = snap.val()
	}
})

IO.on("connection", socket => {
	let inactive = false
	const sendToClient = (ev: string, tag: string, ...args: any[]) => {
		IO.emit(ev + "_" + tag, ...args)
	}

	socket.on("search", (...args) => {
		search(sendToClient, () => inactive, youtubeApi, ...args).then()
	})
	socket.onAny((...args) => {
		console.log("Socket", args)
	})

	socket.on("disconnect", () => inactive = true)
})

app.get(/^\/soundroid-v.*\.apk/, (req, res) => {
	admin
		.storage()
		.bucket("gs://android-soundroid.appspot.com")
		.file(`soundroid-v${VERSION}.apk`)
		.getSignedUrl({
			action: "read",
			expires: Date.now() + 15 * 60 * 1000
		})
		.then(url => res.redirect(url[0]))
		.catch(() => res.status(400).send("APK doesn't exist on the server :O"))
})

app.get("/", (_req, res) => {
	res.render("index", { version: VERSION })
})

app.get("/version", (_req, res) => {
	res.send(VERSION)
})

app.get("/playlist/songs", (req, res) => {
	const TAG = `playlist_songs<${v4()}>:`
	console.time(TAG)
	const playlistId = req.query.playlistId

	playlist_songs(TAG, playlistId, youtubeApi)
		.then(songs => res.status(200).send(songs))
		.catch(err => res.status(400).send(err.message))
		.finally(() => console.timeEnd(TAG))
})

app.delete("/playlist/delete", (req, res) => {
	const TAG = `delete_playlist<${v4()}>:`
	console.time(TAG)
	const playlistId = req.body.playlistId

	delete_playlist(TAG, admin.firestore(), playlistId, importing)
		.then(() => res.status(200).send())
		.catch(err => res.status(400).send(err.message))
		.finally(() => console.timeEnd(TAG))
})

app.put("/playlist/edit", (req, res) => {
	const TAG = `edit_playlist<${v4()}>:`
	console.time(TAG)

	edit_playlist(TAG, admin.firestore(), req.body, importing)
		.then(() => res.status(200).send())
		.catch(err => res.status(400).send(err.message))
		.finally(() => console.timeEnd(TAG))
})

app.put("/song/edit", (req, res) => {
	const TAG = `edit_song<${v4()}>`
	console.time(TAG)

	edit_song(TAG, admin.firestore(), req.body)
		.then(() => res.status(200).send())
		.catch(err => res.status(400).send(err.message))
		.finally(() => console.timeEnd(TAG))
})

app.put("/playlist/save", (req, res) => {
	const TAG = `save_playlist<${v4()}>:`
	console.time(TAG)

	save_playlist(TAG, admin.firestore(), youtubeApi, req.body)
		.then(() => res.status(200).send())
		.catch(err => res.status(400).send(err.message))
		.finally(() => console.timeEnd(TAG))
})

app.post("/playlist/import", (req, res) => {
	const TAG = `import_playlist<${v4()}>:`
	console.time(TAG)

	import_playlist(TAG, admin.firestore(), youtubeApi, req.body, importing, () => res.status(200).send())
		.then(() => console.log(TAG, "All Songs added"))
		.catch(err => res.status(400).send(err.message))
		.finally(() => {
			console.timeEnd(TAG)
			delete importing[req.body.userId]
		})
})

app.post("/playlists/default", (req, res) => {
	const TAG = `default_playlists<${v4()}>:`
	console.time(TAG)
	const userId = req.body.userId

	default_playlists(
		TAG,
		admin.firestore(),
		userId
	)
		.then(() => console.log(TAG, "All Songs added"))
		.catch(err => res.status(400).send(err.message))
		.finally(() => console.timeEnd(TAG))
})

app.get("/song/lyrics", (req, res) => {
	const TAG = `get_lyrics<${v4()}>:`
	console.time(TAG)
	const query = req.query.query

	get_lyrics(TAG, genius, query)
		.then(lines => res.status(200).send(lines))
		.catch(err => res.status(400).send(err.message))
		.finally(() => console.timeEnd(TAG))
})

app.get("/song/:quality_/:filename", get_full_song)

app.get("/ping/:quality_/:filename", get_ping_song)

app.get("/play/:quality_/:filename", get_play_song)

youtubeApi.initalize().then(() => console.log("Initialized YouTube API"))
server.listen(PORT, () => console.log(`Server started on PORT ${PORT}`))
