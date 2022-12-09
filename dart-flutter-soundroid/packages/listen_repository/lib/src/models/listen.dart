import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'listen.g.dart';

/// Listen model returned by Firestore
/// - `@CopyWith`
/// - `Equatable`
@CopyWith()
class Listen extends Equatable {
  const Listen({
    required this.userRef,
    required this.trackIds,
    required this.timestamp,
  });

  /// The reference to the user who listened to the [trackIds]
  final DocumentReference userRef;

  /// The IDs of the Tracks the [userRef] listened to on the same day as [timestamp]
  final List<String> trackIds;

  /// The timestamp of the day the [userRef] listened to the [trackIds]
  ///
  /// The time should be `00:00:00`
  final Timestamp timestamp;

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
