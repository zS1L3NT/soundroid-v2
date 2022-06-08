import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/playlist.dart';

class PlaylistRepository {
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

  Stream<Playlist?> getPlaylist(String id) {
    return _collection.doc(id).snapshots().map((doc) => doc.data());
  }

  String get newId => _collection.doc().id;

  Future<void> addPlaylist(Playlist playlist) {
    return _collection.add(playlist);
  }

  Future<void> updatePlaylist(Playlist playlist) {
    return _collection.doc(playlist.id).update(playlist.toJson());
  }

  Future<void> deletePlaylist(Playlist playlist) {
    return _collection.doc(playlist.id).delete();
  }
}
