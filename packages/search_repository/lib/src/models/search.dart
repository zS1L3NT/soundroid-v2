import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'search.g.dart';

@CopyWith()
class Search extends Equatable {
  final DocumentReference userRef;
  final String query;
  final Timestamp timestamp;

  const Search({
    required this.userRef,
    required this.query,
    required this.timestamp,
  });

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
