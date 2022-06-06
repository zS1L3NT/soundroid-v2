import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/repositories/users_repository.dart';

class PlaylistsRepository {
  final _usersRepo = UsersRepository();
  final _collection = FirebaseFirestore.instance.collection("playlists").withConverter<Playlist>(
        fromFirestore: (snap, _) => Playlist.fromJson(snap.data()!),
        toFirestore: (playlist, _) => playlist.toJson(),
      );

  Stream<List<Playlist>> playlists() {
    return _collection
        .where("userRef", isEqualTo: _usersRepo.currentUserRef)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }

  Stream<Playlist?> playlist(String id) {
    return _collection.doc(id).snapshots().map((doc) => doc.data());
  }

  Future<void> add(Playlist playlist) async {
    await _collection.add(playlist);
  }

  Future<void> update(Playlist playlist) async {
    await _collection.doc(playlist.id).update(playlist.toJson());
  }

  Future<void> delete(Playlist playlist) async {
    await _collection.doc(playlist.id).delete();
  }
}
