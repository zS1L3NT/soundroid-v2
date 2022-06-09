import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user.dart';

class AuthenticationRepository {
  final _document = FirebaseFirestore.instance
      .collection("users")
      .withConverter<User>(
        fromFirestore: (snap, _) => User.fromJson(snap.data()!),
        toFirestore: (user, _) => user.toJson(),
      )
      .doc("jnbZI9qOLtVsehqd6ICcw584ED93");

  DocumentReference<User> get currentUserRef => _document;

  Stream<User?> get currentUser => _document.snapshots().map((snap) => snap.data());

  Future<void> addUser(User user) {
    return _document.set(user);
  }

  Future<void> updateUser(User user) {
    return _document.update(user.toJson());
  }

  Future<void> deleteUser() {
    return _document.delete();
  }
}
