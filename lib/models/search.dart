import 'package:cloud_firestore/cloud_firestore.dart';

class Search {
  final DocumentReference userRef;
  final String query;
  final Timestamp timestamp;

  Search({
    required this.userRef,
    required this.query,
    required this.timestamp,
  });

  static CollectionReference<Search> collection =
      FirebaseFirestore.instance.collection("searches").withConverter(
            fromFirestore: (snap, _) => Search.fromJson(snap.data()!),
            toFirestore: (search, _) => search.toJson(),
          );

  Search.fromJson(Map<String, dynamic> json)
      : userRef = json["userRef"],
        query = json["query"],
        timestamp = json["timestamp"];

  Map<String, dynamic> toJson() => {
        "userRef": userRef,
        "query": query,
        "timestamp": timestamp,
      };
}
