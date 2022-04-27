export interface Song {
	type?: "Song"
	songId: string
	title: string
	artiste: string
	cover: string
	playlistId: string
	userId: string
}

export interface Playlist {
	type?: "Playlist"
	id: string
	name: string
	cover: string
	userId: string
	order: string[]
}
