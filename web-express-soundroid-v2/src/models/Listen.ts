import { DocumentReference, FirestoreDataConverter, Timestamp } from "firebase-admin/firestore"

export default class Listen {
	constructor(
		public userRef: DocumentReference,
		public trackIds: string[],
		public timestamp: Timestamp
	) {}

	static converter: FirestoreDataConverter<Listen> = {
		toFirestore: listen => ({
			userRef: listen.userRef,
			trackIds: listen.trackIds,
			timestamp: listen.timestamp
		}),
		fromFirestore: snap =>
			new Listen(snap.get("userRef"), snap.get("trackIds"), snap.get("timestamp"))
	}
}
