import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'search.g.dart';

/// Search model returned by Firestore
/// - `@CopyWith`
/// - `Equatable`
@CopyWith()
class Search extends Equatable {
  const Search({
    required this.userRef,
    required this.query,
    required this.timestamp,
  });

  /// The reference to the user that created the Search
  final DocumentReference userRef;

  /// The query that was searched for
  final String query;

  /// The time the Search was created
  final Timestamp timestamp;

  Search.fromJson(Map<String, dynamic> json)
      : userRef = json["userRef"],
        query = json["query"],
        timestamp = json["timestamp"];

  Map<String, dynamic> toJson() => {
        "userRef": userRef,
        "query": query,
        "timestamp": timestamp,
      };

  @override
  List<Object?> get props => [
        userRef,
        query,
        timestamp,
      ];

  @override
  String toString() {
    return "Search { ${userRef.id}; $query; ${timestamp.toDate()} }";
  }
}
