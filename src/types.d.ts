export interface Song {
	type?: "Song"
	songId: string
	title: string
	artiste: string
	cover: string
	colorHex: string
	playlistId: string
	userId: string
}

export interface Playlist {
	type?: "Playlist"
	id: string
	name: string
	cover: string
	colorHex: string
	userId: string
	order: string[]
}
