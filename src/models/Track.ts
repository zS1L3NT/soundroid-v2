export default class Track {
	constructor(
		public id: string,
		public title: string,
		public artistIds: string[],
		public thumbnail: string
	) {}
}
