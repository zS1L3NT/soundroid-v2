const ColorThief = require("colorthief")

export default async (url: string) => {
	try {
		const [r, g, b] = await ColorThief.getColor(url) as number[]

		let rs = r.toString(16)
		let gs = g.toString(16)
		let bs = b.toString(16)

		if (rs.length == 1) rs = "0" + rs
		if (gs.length == 1) gs = "0" + gs
		if (bs.length == 1) bs = "0" + bs

		return "#" + rs + gs + bs
	} catch (err) {
		console.error(err)
		return "#FFFFFF"
	}
}