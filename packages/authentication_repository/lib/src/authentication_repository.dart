import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, GoogleAuthProvider;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<bool> signInWithGoogle() async {
    try {
      final account = await GoogleSignIn().signIn();
      final authentication = await account?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: authentication?.accessToken,
        idToken: authentication?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      debugPrint("ERROR Google Sign In Failed: $e");
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      debugPrint("ERROR Login Failed: $e");
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      debugPrint("ERROR Google Sign Out Failed: $e");
      return false;
    }
  }

  /// Update the currently signed in user's data
  void updateUser(User user) async {
    return _document.update(user.toJson());
  }

  /// Delete the currently signed in user's data
  void deleteUser() async {
    return _document.delete();
  }
}
