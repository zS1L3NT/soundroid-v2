import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundroid/models/user.dart';

class UsersRepository {
  final _collection = FirebaseFirestore.instance.collection("users").withConverter(
        fromFirestore: (snap, _) => User.fromJson(snap.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  DocumentReference get currentUserRef => _collection.doc("jnbZI9qOLtVsehqd6ICcw584ED93");
}
