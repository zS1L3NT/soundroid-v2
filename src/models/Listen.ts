import { DocumentReference, FirestoreDataConverter, Timestamp } from "firebase-admin/firestore"

export default class Listen {
	constructor(
		public userId: DocumentReference,
		public trackIds: string[],
		public timestamp: Timestamp
	) {}

	static converter: FirestoreDataConverter<Listen> = {
		toFirestore: listen => ({
			userId: listen.userId,
			trackIds: listen.trackIds,
			timestamp: listen.timestamp
		}),
		fromFirestore: snap =>
			new Listen(snap.get("userId"), snap.get("trackIds"), snap.get("timestamp"))
	}
}
