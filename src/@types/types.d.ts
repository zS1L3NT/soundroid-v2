declare interface User {
	id: string
	name: string
	email: string
	picture: string
	verified: boolean
	likedTrackIds: string[]
}

declare interface Playlist {
	id: string
	userId: string
	name: string
	thumbnail: string
	favourite: boolean
	trackIds: string[]
}

declare interface Listen {
	trackId: string
	userId: string
	timestamp: number
}

declare interface Search {
	userId: string
	query: string
	timestamp: number
}

declare interface Track {
	id: string
	title: string
	artistIds: string[]
	thumbnail: string
}

declare interface Artist {
	id: string
	name: string
	picture: string
}
