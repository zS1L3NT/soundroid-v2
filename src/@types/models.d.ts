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

export interface Track {
	trackId: string
	title: string
	thumbnail: string
	colorHex: string
}

export interface Artist {
	artistId: string
	name: string
	thumbnail: string
	description: string
}
