import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

/// The Authentication Repository contains all Firebase calls regarding authentication and user data.
class AuthenticationRepository {
  /// A [DocumentReference] to the currently signed in user.
  ///
  /// A user should only be able to modify his data and no one elses.
  DocumentReference<User> get _document => FirebaseFirestore.instance
      .collection("users")
      .withConverter<User>(
        fromFirestore: (snap, _) => User.fromJson(snap.data()!),
        toFirestore: (user, _) => user.toJson(),
      )
      .doc(FirebaseAuth.instance.currentUser!.uid);

  /// The document reference of the currently signed in user
  DocumentReference<User> get currentUserRef => _document;

  /// Get a stream of the current user data
  Stream<User?> get currentUser => _document.snapshots().map((snap) => snap.data());

  /// Update the currently signed in user's data
  void updateUser(User user) async {
    return _document.update(user.toJson());
  }

  /// Delete the currently signed in user's data
  void deleteUser() async {
    return _document.delete();
  }
}
