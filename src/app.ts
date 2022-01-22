import admin from "firebase-admin"
import Cache from "./Cache"
import express from "express"
import ffmpeg from "fluent-ffmpeg"
import fs from "fs"
import http from "http"
import path from "path"
import search from "./functions/search"
import { Server } from "socket.io"

const app = express()
const server = http.createServer(app)
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
	credential: admin.credential.cert(require("./config.json").firebase.service_account),
	databaseURL: "https://android-soundroid-default-rtdb.asia-southeast1.firebasedatabase.app"
})

// app.use(express.json())
app.use("/", express.static(path.join(__dirname, "../public")))
app.use("/part/highest", express.static(path.join(__dirname, "..", "part", "highest")))
app.use("/part/lowest", express.static(path.join(__dirname, "..", "part", "lowest")))
app.use("/song/highest", express.static(path.join(__dirname, "..", "song", "highest")))
app.use("/song/lowest", express.static(path.join(__dirname, "..", "song", "lowest")))

IO.on("connection", socket => {
	let inactive = false

	socket.on("search", (...args) => {
		search(IO, () => inactive, args.at(0)).then()
	})

	socket.on("disconnect", () => (inactive = true))
})

const readRouteFolder = (folderName: string) => {
	const folderPath = path.join(__dirname, folderName)

	for (const entityName of fs.readdirSync(folderPath)) {
		const [fileName, extensionName] = entityName.split(".")
		const pathName = `${folderName}/${fileName}`

		if (extensionName) {
			// Entity is a file
			const file = require(path.join(folderPath, entityName)) as Record<any, any>
			for (const [method, handler] of Object.entries(file)) {
				app[method.toLowerCase() as "get" | "post" | "put" | "delete"](
					pathName.replace(/\[(\w+)\]/g, ":$1"),
					handler
				)
			}
		} else {
			readRouteFolder(pathName)
		}
	}
}

readRouteFolder("routes")

app.listen(PORT, () => console.log(`Server started on PORT ${PORT}`))

export const cache = new Cache()
