import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'playlist.g.dart';

/// Playlist Model returned by Firestore
/// - `@CopyWith`
/// - `Equatable`
@CopyWith()
class Playlist extends Equatable {
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

  /// The ID of the Playlist in Firestore
  final String id;

  /// The reference to the user that created the Playlist
  final DocumentReference userRef;

  /// The last time the Playlist was played
  final Timestamp? lastPlayed;

  /// The name of the Playlist
  final String name;

  /// The thumbnail of the Playlist, if any
  final String? thumbnail;

  /// Whether the Playlist is a favourite
  final bool favourite;

  /// Whether the Playlist should be downloaded
  final bool download;

  /// The IDs of the Tracks in the Playlist
  final List<String> trackIds;

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
