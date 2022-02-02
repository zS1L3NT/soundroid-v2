import config from "./config.json"
import Genius from "node-genius-api"
import path from "path"
import SpotifyWebApi from "spotify-web-api-node"
import YTMusic from "ytmusic-api"
import { useTryAsync } from "no-try"

type PromiseCallback = {
	resolve: (value: PromiseLike<string> | string) => void
	reject: (reason?: any) => void
}

export default class Cache {
	public ytmusic_api = new YTMusic()
	public spotify_api = new Spotify()
	public genius_api = new Genius(config.genius)

	public importing: Record<string, string> = {}
	public converting: Record<string, PromiseCallback[]> = {}

	public constructor() {
		this.ytmusic_api.initialize()
		this.spotify_api.authenticate()
	}

	public getPartialPath(trackId: string, quality: "highest" | "lowest"): string {
		return path.join(__dirname, `../public/audio/partial/${trackId}-${quality}.mp3`)
	}

	public getTrackPath(trackId: string, quality: "highest" | "lowest"): string {
		return path.join(__dirname, `../public/audio/track/${trackId}-${quality}.mp3`)
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
