export { default as Spotify } from "./spotify"
export { default as convert_song } from "./requests/convert_song"
export { default as playlist_songs } from "./requests/playlist_songs"
export { default as search } from "./requests/search"
export { default as color_thief } from "./color_thief"
export { default as save_playlist } from "./requests/save_playlist"
export { default as edit_playlist } from "./requests/edit_playlist"
export { default as delete_playlist } from "./requests/delete_playlist"
export { default as edit_song } from "./requests/edit_song"
export { default as default_playlists } from "./requests/default_playlists"
export { default as import_playlist } from "./requests/import_playlist"
export { default as get_full_song } from "./requests/get_full_song"
export { default as get_ping_song } from "./requests/get_ping_song"
export { default as get_play_song } from "./requests/get_play_song"
export { default as get_lyrics } from "./requests/get_lyrics"

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