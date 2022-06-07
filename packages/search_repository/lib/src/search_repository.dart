import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/models.dart';

class SearchRepository {
  final _authenticationRepo = AuthenticationRepository();
  final _collection = FirebaseFirestore.instance.collection("searches").withConverter<Search>(
        fromFirestore: (snap, _) => Search.fromJson(snap.data()!),
        toFirestore: (search, _) => search.toJson(),
      );

  Stream<List<Search>> getSearches() {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }
}
