import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'listen.g.dart';

@CopyWith()
class Listen extends Equatable {
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
        trackIds = json["trackIds"].cast<String>(),
        timestamp = json["timestamp"];

  Map<String, dynamic> toJson() => {
        "userRef": userRef,
        "trackIds": trackIds,
        "timestamp": timestamp,
      };

  @override
  List<Object?> get props => [
        userRef,
        trackIds,
        timestamp,
      ];

  @override
  String toString() {
    return "Listen { ${userRef.id}; $trackIds; ${timestamp.toDate()} }";
  }
}
