import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/models.dart';

class ListenRepository {
  final _authenticationRepo = AuthenticationRepository();
  final _collection = FirebaseFirestore.instance.collection("listens").withConverter<Listen>(
        fromFirestore: (snap, _) => Listen.fromJson(snap.data()!),
        toFirestore: (listen, _) => listen.toJson(),
      );

  Stream<Listen?> getListen() {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .where("timestamp", isLessThanOrEqualTo: Timestamp.now())
        .where(
          "timestamp",
          isGreaterThanOrEqualTo: Timestamp.fromDate(
            DateTime.now().subtract(const Duration(days: 1)),
          ),
        )
        .limit(1)
        .snapshots()
        .map((snap) => snap.docs.first.data());
  }

  Future<void> addListen(Listen listen) {
    return _collection.add(listen);
  }

  Future<void> updateListen(Listen listen) {
    return _collection
        .where("userRef", isEqualTo: _authenticationRepo.currentUserRef)
        .where("timestamp", isEqualTo: listen.timestamp)
        .limit(1)
        .get()
        .then((snap) => snap.docs.first.reference.update(listen.toJson()));
  }
}
