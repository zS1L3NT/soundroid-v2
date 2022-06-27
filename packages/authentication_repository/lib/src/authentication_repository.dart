import 'package:authentication_repository/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// The Authentication Repository contains all Firebase calls regarding authentication and user data.
class AuthenticationRepository {
  /// A [DocumentReference] to the currently signed in user.
  ///
  /// A user should only be able to modify his data and no one elses.
  final _document = FirebaseFirestore.instance
      .collection("users")
      .withConverter<User>(
        fromFirestore: (snap, _) => User.fromJson(snap.data()!),
        toFirestore: (user, _) => user.toJson(),
      )
      .doc("jnbZI9qOLtVsehqd6ICcw584ED93");

  /// The document reference of the currently signed in user
  DocumentReference<User> get currentUserRef => _document;

  /// Get a stream of the current user data
  Stream<User?> get currentUser => _document.snapshots().map((snap) => snap.data());

  /// Update the currently signed in user's data
  Future<void> updateUser(User user) {
    return _document.update(user.toJson());
  }

  /// Delete the currently signed in user's data
  Future<void> deleteUser() {
    return _document.delete();
  }
}
