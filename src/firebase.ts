import { cert, initializeApp } from "firebase-admin/app"

export const firebaseApp = initializeApp({
	credential: cert({
		projectId: process.env.FIREBASE__SERVICE_ACCOUNT__PROJECT_ID,
		clientEmail: process.env.FIREBASE__SERVICE_ACCOUNT__CLIENT_EMAIL,
		privateKey: process.env.FIREBASE__SERVICE_ACCOUNT__PRIVATE_KEY
	})
})
