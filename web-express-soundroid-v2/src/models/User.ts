import { FirestoreDataConverter } from "firebase-admin/firestore"

export default class User {
	constructor(
		public name: string,
		public email: string,
		public picture: string,
		public verified: boolean,
		public likedTrackIds: string[]
	) {}

	static converter: FirestoreDataConverter<User> = {
		toFirestore: user => ({
			name: user.name,
			email: user.email,
			picture: user.picture,
			verified: user.verified,
			likedTrackIds: user.likedTrackIds
		}),
		fromFirestore: snap =>
			new User(
				snap.get("name"),
				snap.get("email"),
				snap.get("picture"),
				snap.get("verified"),
				snap.get("likedTrackIds")
			)
	}
}
