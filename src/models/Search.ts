import { FirestoreDataConverter } from "firebase-admin/firestore"

export default class Search {
	constructor(public userId: string, public query: string, public date: number) {}

	static converter: FirestoreDataConverter<Search> = {
		toFirestore: listen => ({
			userId: listen.userId,
			query: listen.query,
			date: listen.date
		}),
		fromFirestore: snap => new Search(snap.get("userId"), snap.get("query"), snap.get("date"))
	}
}
