import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_repository/src/models/models.dart';

/// The Search Repository contains all Firebase calls regarding search data
class SearchRepository {
  final _authenticationRepo = AuthenticationRepository();
  final _collection = FirebaseFirestore.instance.collection("searches").withConverter<Search>(
        fromFirestore: (snap, _) => Search.fromJson(snap.data()!),
        toFirestore: (search, _) => search.toJson(),
      );

  /// Get a stream of the currently authenticated user's searches
  Stream<List<Search>> getSearches() {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .orderBy("timestamp", descending: true)
        .limit(10)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }

  /// Fetch a list of recent searches by the currently authenticated user
  Future<List<String>> getRecentSearches(String query) {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .where("query", isGreaterThanOrEqualTo: query)
        .where("query", isLessThanOrEqualTo: query + "~")
        .limit(10)
        .get()
        .then((snap) => snap.docs.map((doc) => doc.data().query).toList());
  }

  /// Delete a search from history by the text of the search
  Future<void> deleteSearch(String text) {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .where("query", isEqualTo: text)
        .get()
        .then((snap) => snap.docs.first.reference.delete());
  }

  Future<bool> deleteAll() async {
    try {
      final searches = await _collection
          .where(
            "userRef",
            isEqualTo: _authenticationRepo.currentUserRef,
          )
          .get();
      final batch = FirebaseFirestore.instance.batch();
      for (final listen in searches.docs) {
        batch.delete(listen.reference);
      }
      await batch.commit();
      return true;
    } catch (e) {
      debugPrint("ERROR Delete all searches: $e");
      return false;
    }
  }
}
