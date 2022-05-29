import { cert, initializeApp } from "firebase-admin/app"
import { getAuth } from "firebase-admin/auth"
import { getFirestore } from "firebase-admin/firestore"
import { useTryAsync } from "no-try"
import SpotifyWebApi from "spotify-web-api-node"
import YTMusic from "ytmusic-api"

import Listen from "./models/Listen"
import Playlist from "./models/Playlist"
import Search from "./models/Search"
import User from "./models/User"

export const firebaseApp = initializeApp({
	credential: cert({
		projectId: process.env.FIREBASE__SERVICE_ACCOUNT__PROJECT_ID,
		clientEmail: process.env.FIREBASE__SERVICE_ACCOUNT__CLIENT_EMAIL,
		privateKey: process.env.FIREBASE__SERVICE_ACCOUNT__PRIVATE_KEY
	})
})

export const firestore = getFirestore(firebaseApp)
export const usersColl = firestore.collection("users").withConverter(User.converter)
export const playlistsColl = firestore.collection("playlists").withConverter(Playlist.converter)
export const listensColl = firestore.collection("listens").withConverter(Listen.converter)
export const searchesColl = firestore.collection("searches").withConverter(Search.converter)

export const auth = getAuth(firebaseApp)

export const ytmusic = new YTMusic()
ytmusic.initialize().then(() => console.log("YTMusic Initialized"))

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
