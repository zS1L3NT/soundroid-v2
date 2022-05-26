import { DocumentReference, FirestoreDataConverter, Timestamp } from "firebase-admin/firestore"

export default class Search {
	constructor(
		public userId: DocumentReference,
		public query: string,
		public timestamp: Timestamp
	) {}

	static converter: FirestoreDataConverter<Search> = {
		toFirestore: listen => ({
			userId: listen.userId,
			query: listen.query,
			timestamp: listen.timestamp
		}),
		fromFirestore: snap =>
			new Search(snap.get("userId"), snap.get("query"), snap.get("timestamp"))
	}
}
