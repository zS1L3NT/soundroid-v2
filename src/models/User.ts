import { FirestoreDataConverter } from "firebase-admin/firestore"

export default class User {
	constructor(
		public id: string,
		public name: string,
		public email: string,
		public picture: string,
		public verified: boolean,
		public likedTrackIds: string[]
	) {}

	static converter: FirestoreDataConverter<User> = {
		toFirestore: user => ({
			id: user.id,
			name: user.name,
			email: user.email,
			picture: user.picture,
			verified: user.verified,
			likedTrackIds: user.likedTrackIds
		}),
		fromFirestore: snap =>
			new User(
				snap.get("id"),
				snap.get("name"),
				snap.get("email"),
				snap.get("picture"),
				snap.get("verified"),
				snap.get("likedTrackIds")
			)
	}
}
