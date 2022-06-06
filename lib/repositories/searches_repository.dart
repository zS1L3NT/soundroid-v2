import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundroid/models/search.dart';
import 'package:soundroid/repositories/users_repository.dart';

class SearchesRepository {
  final _usersRepo = UsersRepository();
  final _collection = FirebaseFirestore.instance.collection("searches").withConverter<Search>(
        fromFirestore: (snap, _) => Search.fromJson(snap.data()!),
        toFirestore: (search, _) => search.toJson(),
      );

  Stream<List<Search>> searches() {
    return _collection
        .where("userRef", isEqualTo: _usersRepo.currentUserRef)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }
}
