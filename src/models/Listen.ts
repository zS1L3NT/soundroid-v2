import { DocumentReference, FirestoreDataConverter } from "firebase-admin/firestore"

export default class Listen {
	constructor(public userId: DocumentReference, public trackId: string, public count: number) {}

	static converter: FirestoreDataConverter<Listen> = {
		toFirestore: listen => ({
			userId: listen.userId,
			trackId: listen.trackId,
			count: listen.count
		}),
		fromFirestore: snap =>
			new Listen(snap.get("userId"), snap.get("trackId"), snap.get("count"))
	}
}
