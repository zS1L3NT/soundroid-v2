export default (url = "") => {
	if (url === "") {
		return url
	} else if (url.match(/w\d+-h\d+/)) {
		return url.replace(/w\d+-h\d+/, "w500-h500")
	} else {
		const host =
			process.env.NODE_ENV === "production" ? process.env.API_URL : "http://localhost:5190"
		return `${host}/api/thumbnail?url=` + encodeURIComponent(url)
	}
}
