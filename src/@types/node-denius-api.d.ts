declare module "node-genius-api" {
	class Genius {
		public constructor(apiKey: string)
		public search(query: string): any
		public lyrics(songId: string): any
	}

	export default Genius
}
