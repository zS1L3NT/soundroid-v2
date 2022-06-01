import 'package:cloud_firestore/cloud_firestore.dart';

class Listen {
  final DocumentReference userRef;
  final List<String> trackIds;
  final Timestamp timestamp;

  Listen({
    required this.userRef,
    required this.trackIds,
    required this.timestamp,
  });

  static CollectionReference<Listen> collection =
      FirebaseFirestore.instance.collection("listens").withConverter(
            fromFirestore: (snap, _) => Listen.fromJson(snap.data()!),
            toFirestore: (listen, _) => listen.toJson(),
          );

  Listen.fromJson(Map<String, dynamic> json)
      : userRef = json["userRef"],
        trackIds = json["trackIds"].cast<String>(),
        timestamp = json["timestamp"];

  Map<String, dynamic> toJson() => {
        "userRef": userRef,
        "trackIds": trackIds,
        "timestamp": timestamp,
      };
}
