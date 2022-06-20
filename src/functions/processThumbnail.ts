import axios from "axios"
import sharp from "sharp"

export default async (url = "") => {
	if (url === "") {
		return url
	} else if (url.match(/w\d+-h\d+/)) {
		return url.replace(/w\d+-h\d+/, "w500-h500")
	} else {
		const buffer = (await axios.get(url, { responseType: "arraybuffer" })).data as Buffer
		const resizedBuffer = await sharp(buffer).resize(500, 500).toBuffer()
		return `data:image/png;base64,${resizedBuffer.toString("base64")}`
	}
}
