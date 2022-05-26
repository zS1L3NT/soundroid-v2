import { DocumentReference, FirestoreDataConverter } from "firebase-admin/firestore"

export default class Playlist {
	constructor(
		public userRef: DocumentReference,
		public name: string,
		public thumbnail: string,
		public favourite: boolean,
		public trackIds: string[]
	) {}

	static converter: FirestoreDataConverter<Playlist> = {
		toFirestore: listen => ({
			userRef: listen.userRef,
			name: listen.name,
			thumbnail: listen.thumbnail,
			favourite: listen.favourite,
			trackIds: listen.trackIds
		}),
		fromFirestore: snap =>
			new Playlist(
				snap.get("userRef"),
				snap.get("name"),
				snap.get("thumbnail"),
				snap.get("favourite"),
				snap.get("trackIds")
			)
	}
}
