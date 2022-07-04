import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:playlist_repository/src/models/models.dart';

/// The Playlist Repository contains all Firebase calls regarding playlist data and thumbnail storage
class PlaylistRepository {
  final _storage = FirebaseStorage.instance;
  final _authenticationRepo = AuthenticationRepository();
  final _collection = FirebaseFirestore.instance.collection("playlists").withConverter<Playlist>(
        fromFirestore: (snap, _) => Playlist.fromJson(snap.data()!),
        toFirestore: (playlist, _) => playlist.toJson(),
      );

  /// Get a stream of the currently authenticated user's playlists
  Stream<List<Playlist>> getPlaylists() {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }

  /// Get a stream of the currently authenticated user's last 4 played playlists
  Stream<List<Playlist>> getRecentPlaylists() {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .orderBy("lastPlayed", descending: true)
        .limit(3)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }

  /// Gets a stream of all tracks that need to be downloaded in all playlists
  Stream<List<String>> getDownloadedTrackIds() {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .where("download", isEqualTo: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => doc.data().trackIds)
              // Flatten the list
              .expand((i) => i)
              // Remove duplicates
              .toSet()
              .toList(),
        );
  }

  /// Get a stream of a specific playlist by the [Playlist.id]
  Stream<Playlist?> getPlaylist(String id) {
    return _collection.doc(id).snapshots().map((doc) => doc.data());
  }

  /// Get an id of a new document in the playlists collection
  String get newId => _collection.doc().id;

  /// Get the current timestamp
  static Timestamp get now => Timestamp.now();

  /// Create a new playlist
  Future<void> addPlaylist(Playlist playlist) {
    return _collection.doc(playlist.id).set(playlist);
  }

  /// Update a playlist
  Future<void> updatePlaylist(Playlist playlist) {
    return _collection.doc(playlist.id).update(playlist.toJson());
  }

  /// Delete a playlist
  Future<void> deletePlaylist(String id) {
    return _collection.doc(id).delete();
  }

  /// Get the url of a playlist thumbnail in Firebase Storage
  Future<String> getPicture(String id) {
    return _storage.ref("playlists/$id.png").getDownloadURL();
  }

  /// Upload a playlist thumbnail to Firebase Storage
  Future<void> setPicture(String id, File file) {
    return _storage.ref("playlists/$id.png").putFile(file);
  }

  /// Delete a playlist thumbnail from Firebase Storage
  Future<void> deletePicture(String id) {
    return _storage.ref("playlists/$id.png").delete();
  }
}
