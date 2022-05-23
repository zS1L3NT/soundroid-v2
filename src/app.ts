import "dotenv/config"

import express from "express"
import fs from "fs"
import path from "path"

import { iRoute } from "./Route"

const app = express()
const PORT = process.env.PORT || 5190

app.use(express.json())
app.use(express.static(path.join(__dirname, "../public")))

const readRouteFolder = (folderName: string) => {
	const folderPath = path.join(__dirname, "routes", folderName)

	for (const entityName of fs.readdirSync(folderPath)) {
		const [fileName, extensionName] = entityName.split(".")
		const pathName = `${folderName}/${fileName}`

		if (extensionName) {
			// Entity is a file
			const file = require(path.join(folderPath, entityName)) as Record<string, iRoute>
			for (const [method, Route] of Object.entries(file)) {
				app[method.toLowerCase() as "get" | "post" | "put" | "delete"](
					pathName.replace(/\[(\w+)\]/g, ":$1"),
					(req, res) => new Route(req, res)
				)
			}
		} else {
			readRouteFolder(pathName)
		}
	}
}

readRouteFolder("")

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`))
