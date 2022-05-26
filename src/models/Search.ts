import { DocumentReference, FirestoreDataConverter, Timestamp } from "firebase-admin/firestore"

export default class Search {
	constructor(
		public userRef: DocumentReference,
		public query: string,
		public timestamp: Timestamp
	) {}

	static converter: FirestoreDataConverter<Search> = {
		toFirestore: listen => ({
			userRef: listen.userRef,
			query: listen.query,
			timestamp: listen.timestamp
		}),
		fromFirestore: snap =>
			new Search(snap.get("userRef"), snap.get("query"), snap.get("timestamp"))
	}
}
