import { cert, initializeApp } from "firebase-admin/app"
import { useTryAsync } from "no-try"
import Genius from "node-genius-api"
import SpotifyWebApi from "spotify-web-api-node"
import YTMusic from "ytmusic-api"

export const firebaseApp = initializeApp({
	credential: cert({
		projectId: process.env.FIREBASE__SERVICE_ACCOUNT__PROJECT_ID,
		clientEmail: process.env.FIREBASE__SERVICE_ACCOUNT__CLIENT_EMAIL,
		privateKey: process.env.FIREBASE__SERVICE_ACCOUNT__PRIVATE_KEY
	})
})

export const ytmusic = new YTMusic()
ytmusic.initialize()

class Spotify extends SpotifyWebApi {
	constructor() {
		super({
			clientId: process.env.SPOTIFY__CLIENT_ID,
			clientSecret: process.env.SPOTIFY__CLIENT_SECRET,
			refreshToken: process.env.SPOTIFY__REFRESH_TOKEN
		})
		this.authenticate()
	}

	async authenticate() {
		this.setAccessToken((await this.clientCredentialsGrant()).body.access_token)
	}

	async authenticated<T>(func: () => Promise<{ body: T }>): Promise<T> {
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
