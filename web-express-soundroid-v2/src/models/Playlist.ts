import { DocumentReference, FirestoreDataConverter, Timestamp } from "firebase-admin/firestore"

export default class Playlist {
	constructor(
		public id: String,
		public userRef: DocumentReference,
		public lastPlayed: Timestamp | null,
		public name: string,
		public thumbnail: string | null,
		public favourite: boolean,
		public download: boolean,
		public trackIds: string[]
	) {}

	static converter: FirestoreDataConverter<Playlist> = {
		toFirestore: listen => ({
			id: listen.id,
			userRef: listen.userRef,
			lastPlayed: listen.lastPlayed,
			name: listen.name,
			thumbnail: listen.thumbnail,
			favourite: listen.favourite,
			download: listen.download,
			trackIds: listen.trackIds
		}),
		fromFirestore: snap =>
			new Playlist(
				snap.get("id"),
				snap.get("userRef"),
				snap.get("lastPlayed"),
				snap.get("name"),
				snap.get("thumbnail"),
				snap.get("favourite"),
				snap.get("download"),
				snap.get("trackIds")
			)
	}
}
