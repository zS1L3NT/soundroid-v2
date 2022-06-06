import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundroid/models/listen.dart';
import 'package:soundroid/repositories/users_repository.dart';

class ListensRepository {
  final _usersRepo = UsersRepository();
  final _collection = FirebaseFirestore.instance.collection("listens").withConverter(
        fromFirestore: (snap, _) => Listen.fromJson(snap.data()!),
        toFirestore: (listen, _) => listen.toJson(),
      );

  Stream<Listen?> listen() {
    return _collection
        .where("userRef", isEqualTo: _usersRepo.currentUserRef)
        .where("timestamp", isLessThanOrEqualTo: Timestamp.now())
        .where(
          "timestamp",
          isGreaterThanOrEqualTo: Timestamp.fromDate(
            DateTime.now().subtract(const Duration(days: 1)),
          ),
        )
        .limit(1)
        .snapshots()
        .map((snap) => snap.docs[0].data());
  }

  Future<void> add(Listen listen) async {
    await _collection.add(listen);
  }

  Future<void> update(Listen listen) async {
    final snap = await _collection
        .where("userRef", isEqualTo: _usersRepo.currentUserRef)
        .where("timestamp", isEqualTo: listen.timestamp)
        .limit(1)
        .get();
    await snap.docs[0].reference.update(listen.toJson());
  }
}
