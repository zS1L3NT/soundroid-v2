export default async (url = "") => {
	if (url === "") {
		return url
	} else if (url.match(/w\d+-h\d+/)) {
		return url.replace(/w\d+-h\d+/, "w500-h500")
	} else {
		const host =
			process.env.NODE_ENV === "production" ? "soundroid.zectan.com" : "localhost:5190"
		return `http://${host}/api/thumbnail?url=` + encodeURIComponent(url)
	}
}
