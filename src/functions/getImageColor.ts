import colorthief from "colorthief"
import { useTryAsync } from "no-try"

export default async (url: string) => {
	const [error, [r, g, b]] = await useTryAsync(() => colorthief.getColor(url))
	if (error) return "#FFFFFF"

	let rs = r.toString(16)
	let gs = g.toString(16)
	let bs = b.toString(16)

	if (rs.length == 1) rs = "0" + rs
	if (gs.length == 1) gs = "0" + gs
	if (bs.length == 1) bs = "0" + bs

	return "#" + rs + gs + bs
}
