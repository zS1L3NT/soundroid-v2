import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'models/playlist.dart';

class PlaylistRepository {
  final _storage = FirebaseStorage.instance;
  final _authenticationRepo = AuthenticationRepository();
  final _collection = FirebaseFirestore.instance.collection("playlists").withConverter<Playlist>(
        fromFirestore: (snap, _) => Playlist.fromJson(snap.data()!),
        toFirestore: (playlist, _) => playlist.toJson(),
      );

  Stream<List<Playlist>> getPlaylists() {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Playlist>> getRecentPlaylists() {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .orderBy("lastPlayed", descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }

  Stream<Playlist?> getPlaylist(String id) {
    return _collection.doc(id).snapshots().map((doc) => doc.data());
  }

  String get newId => _collection.doc().id;

  static Timestamp get now => Timestamp.now();

  Future<void> addPlaylist(Playlist playlist) {
    return _collection.doc(playlist.id).set(playlist);
  }

  Future<void> updatePlaylist(Playlist playlist) {
    return _collection.doc(playlist.id).update(playlist.toJson());
  }

  Future<void> deletePlaylist(String id) {
    return _collection.doc(id).delete();
  }

  Future<String> getPicture(String id) {
    return _storage.ref("playlists/$id.png").getDownloadURL();
  }

  Future<void> setPicture(String id, File file) {
    return _storage.ref("playlists/$id.png").putFile(file);
  }

  Future<void> deletePicture(String id) {
    return _storage.ref("playlists/$id.png").delete();
  }
}
