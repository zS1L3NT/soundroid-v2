import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'playlist.g.dart';

@CopyWith()
class Playlist extends Equatable {
  final String id;
  final DocumentReference userRef;
  final Timestamp? lastPlayed;
  final String name;
  final String? thumbnail;
  final bool favourite;
  final bool download;
  final List<String> trackIds;

  const Playlist({
    required this.id,
    required this.userRef,
    required this.lastPlayed,
    required this.name,
    required this.thumbnail,
    required this.favourite,
    required this.download,
    required this.trackIds,
  });

  Playlist.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userRef = json["userRef"],
        lastPlayed = json["lastPlayed"],
        name = json["name"],
        thumbnail = json["thumbnail"],
        favourite = json["favourite"],
        download = json["download"],
        trackIds = json["trackIds"].cast<String>();

  Map<String, dynamic> toJson() => {
        "id": id,
        "userRef": userRef,
        "lastPlayed": lastPlayed,
        "name": name,
        "thumbnail": thumbnail,
        "favourite": favourite,
        "download": download,
        "trackIds": trackIds,
      };

  @override
  List<Object?> get props => [
        id,
        userRef,
        lastPlayed,
        name,
        thumbnail,
        favourite,
        download,
        trackIds,
      ];

  @override
  String toString() {
    return "Playlist { $id; ${userRef.id}; $lastPlayed; $name; $favourite; $download; $trackIds }";
  }
}
