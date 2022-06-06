import 'package:cloud_firestore/cloud_firestore.dart';

class Playlist {
  final String id;
  final DocumentReference userRef;
  final String name;
  final String? thumbnail;
  final bool favourite;
  final bool download;
  final List<String> trackIds;

  Playlist({
    required this.id,
    required this.userRef,
    required this.name,
    required this.thumbnail,
    required this.favourite,
    required this.download,
    required this.trackIds,
  });

  static CollectionReference<Playlist> collection =
      FirebaseFirestore.instance.collection("playlists").withConverter<Playlist>(
            fromFirestore: (snap, _) => Playlist.fromJson(snap.data()!),
            toFirestore: (playlist, _) => playlist.toJson(),
          );

  Playlist.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userRef = json["userRef"],
        name = json["name"],
        thumbnail = json["thumbnail"],
        favourite = json["favourite"],
        download = json["download"],
        trackIds = json["trackIds"].cast<String>();

  Map<String, dynamic> toJson() => {
        "id": id,
        "userRef": userRef,
        "name": name,
        "thumbnail": thumbnail,
        "favourite": favourite,
        "download": download,
        "trackIds": trackIds,
      };
}
