import { useTryAsync } from "no-try"
import Genius from "node-genius-api"
import SpotifyWebApi from "spotify-web-api-node"
import YTMusic from "ytmusic-api"

export const ytmusic = new YTMusic()
ytmusic.initialize()

class Spotify {
	public api: SpotifyWebApi

	public constructor() {
		this.api = new SpotifyWebApi({
			clientId: process.env.SPOTIFY__CLIENT_ID,
			clientSecret: process.env.SPOTIFY__CLIENT_SECRET,
			refreshToken: process.env.SPOTIFY__REFRESH_TOKEN
		})
		this.authenticate()
	}

	public async authenticate() {
		const data = await this.api.clientCredentialsGrant()
		this.api.setAccessToken(data.body.access_token)
	}

	public async authenticated<T>(func: () => Promise<{ body: T }>): Promise<T> {
		const [error, data] = await useTryAsync(func)

		if (error) {
			if ((error as any).body.error.status === 401) {
				await this.authenticate()
				return await this.authenticated(func)
			}
			throw error
		} else {
			return data.body
		}
	}
}

export const spotify = new Spotify()

export const genius = new Genius(process.env.GENIUS_ACCESS_TOKEN)
