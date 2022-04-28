declare interface User {
	id: string
}

declare interface Playlist {
	id: string
	userId: string
	trackIds: string[]
}

declare interface Track {
	id: string
	title: string
	artists: string
	thumbnail: string
}

declare interface Listen {
	trackId: string
	userId: string
	startTime: number
	endTime: number
}
