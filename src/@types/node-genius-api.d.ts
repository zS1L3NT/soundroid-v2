declare module "node-genius-api" {
	class Genius {
		constructor(apiKey: string)
		search(query: string): any
		lyrics(songId: string): any
	}

	export default Genius
}
