import 'package:cloud_firestore/cloud_firestore.dart';

class Playlist {
  final DocumentReference userRef;
  final String name;
  final String thumbnail;
  final bool favourite;
  final List<String> trackIds;

  Playlist({
    required this.userRef,
    required this.name,
    required this.thumbnail,
    required this.favourite,
    required this.trackIds,
  });

  Playlist.fromJson(Map<String, dynamic> json)
      : userRef = json["userRef"],
        name = json["name"],
        thumbnail = json["thumbnail"],
        favourite = json["favourite"],
        trackIds = json["trackIds"];

  Map<String, dynamic> toJson() => {
        "userRef": userRef,
        "name": name,
        "thumbnail": thumbnail,
        "favourite": favourite,
        "trackIds": trackIds,
      };
}
