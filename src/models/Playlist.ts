import { DocumentReference, FirestoreDataConverter } from "firebase-admin/firestore"

export default class Playlist {
	constructor(
		public userRef: DocumentReference,
		public name: string,
		public thumbnail: string | null,
		public favourite: boolean,
		public download: boolean,
		public trackIds: string[]
	) {}

	static converter: FirestoreDataConverter<Playlist> = {
		toFirestore: listen => ({
			userRef: listen.userRef,
			name: listen.name,
			thumbnail: listen.thumbnail,
			favourite: listen.favourite,
			download: listen.download,
			trackIds: listen.trackIds
		}),
		fromFirestore: snap =>
			new Playlist(
				snap.get("userRef"),
				snap.get("name"),
				snap.get("thumbnail"),
				snap.get("favourite"),
				snap.get("download"),
				snap.get("trackIds")
			)
	}
}
