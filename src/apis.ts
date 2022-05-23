import { cert, initializeApp } from "firebase-admin/app"
import Genius from "node-genius-api"
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

export const genius = new Genius(process.env.GENIUS_ACCESS_TOKEN)
