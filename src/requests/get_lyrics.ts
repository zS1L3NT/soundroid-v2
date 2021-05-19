export default async (TAG: string, genius: any, query: any) => {
	console.log(TAG, `Query: ${query}`)

	const songs = await genius.search(query)
	const song = songs[0]

	if (!song) throw new Error(`Could not find lyrics for this song`)

	const lyrics = await genius.lyrics(song.result.id)
	const lines: string[] = []
	for (let i = 0, il = lyrics.length; i < il; i++) {
		const part = lyrics[i]
		lines.push(...part.content)
	}

	return lines
}
