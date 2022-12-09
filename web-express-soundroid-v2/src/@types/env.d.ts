declare module NodeJS {
	interface ProcessEnv {
		readonly API_URL: string
		readonly FIREBASE__SERVICE_ACCOUNT__CLIENT_EMAIL: string
		readonly FIREBASE__SERVICE_ACCOUNT__PRIVATE_KEY: string
		readonly FIREBASE__SERVICE_ACCOUNT__PROJECT_ID: string
		readonly SPOTIFY__CLIENT_ID: string
		readonly SPOTIFY__CLIENT_SECRET: string
		readonly SPOTIFY__REFRESH_TOKEN: string
	}
}
