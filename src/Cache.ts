import config from "./config.json"
import Genius from "node-genius-api"
import SpotifyWebApi from "spotify-web-api-node"
import YTMusic from "ytmusic-api"
import { useTryAsync } from "no-try"

export default class Cache {
	public importing: Record<string, string> = {}
	public ytmusic_api = new YTMusic()
	public spotify_api = new Spotify()
	public genius_api = new Genius(config.genius)

	public constructor() {
		this.ytmusic_api.initialize()
		this.spotify_api.authenticate()
	}
}

class Spotify {
	public api: SpotifyWebApi

	public constructor() {
		this.api = new SpotifyWebApi(config.spotify)
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
