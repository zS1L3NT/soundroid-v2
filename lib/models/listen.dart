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

  Listen.fromJson(Map<String, dynamic> json)
      : userRef = json["userRef"],
        trackIds = json["trackIds"],
        timestamp = json["timestamp"];

  Map<String, dynamic> toJson() => {
        "userRef": userRef,
        "trackIds": trackIds,
        "timestamp": timestamp,
      };
}
