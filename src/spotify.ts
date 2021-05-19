import SpotifyWebApi from "spotify-web-api-node"

export default class Spotify {
	private spotifyApi: SpotifyWebApi

	public constructor() {
		this.spotifyApi = new SpotifyWebApi(require("../config.json").spotify)
	}

	public async authenticate() {
		const data = await this.spotifyApi.clientCredentialsGrant()
		this.spotifyApi.setAccessToken(data.body.access_token)
	}

	public async getPlaylist(playlistId: string): Promise<SpotifyApi.SinglePlaylistResponse> {
		try {
			return (await this.spotifyApi.getPlaylist(playlistId)).body
		} catch (e) {
			if (e.body.error.status === 401) {
				await this.authenticate()
				return await this.getPlaylist(playlistId)
			}
			throw e
		}
	}

	public async getPlaylistTracks(playlistId: string, offset: number): Promise<SpotifyApi.PlaylistTrackResponse> {
		try {
			return (await this.spotifyApi.getPlaylistTracks(playlistId, {
				offset,
				limit: 100
			})).body
		} catch (e) {
			if (e.body.error.status === 401) {
				await this.authenticate()
				return await this.getPlaylistTracks(playlistId, offset)
			}
			throw e
		}
	}

	public async getAlbum(albumId: string): Promise<SpotifyApi.SingleAlbumResponse> {
		try {
			return (await this.spotifyApi.getAlbum(albumId)).body
		} catch (e) {
			if (e.body.error.status === 401) {
				await this.authenticate()
				return await this.getAlbum(albumId)
			}
			throw e
		}
	}

	public async getAlbumTracks(albumId: string, offset: number): Promise<SpotifyApi.AlbumTracksResponse> {
		try {
			return (await this.spotifyApi.getAlbumTracks(albumId, {
				offset,
				limit: 100
			})).body
		} catch (e) {
			if (e.body.error.status === 401) {
				await this.authenticate()
				return await this.getAlbumTracks(albumId, offset)
			}
			throw e
		}
	}
}