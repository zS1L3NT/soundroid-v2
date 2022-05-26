import { FirestoreDataConverter } from "firebase-admin/firestore"

export default class Listen {
	constructor(public userId: string, public trackId: string, public date: number) {}

	static converter: FirestoreDataConverter<Listen> = {
		toFirestore: listen => ({
			userId: listen.userId,
			trackId: listen.trackId,
			date: listen.date
		}),
		fromFirestore: snap => new Listen(snap.get("userId"), snap.get("trackId"), snap.get("date"))
	}
}
