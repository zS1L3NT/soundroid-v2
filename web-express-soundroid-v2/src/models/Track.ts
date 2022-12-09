import Artist from "./Artist"

export default class Track {
	constructor(
		public id: string,
		public title: string,
		public artists: Artist[],
		public thumbnail: string
	) {}
}
