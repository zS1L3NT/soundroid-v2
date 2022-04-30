class Playlist {
  final String name;
  final String userId;
  final List<String> trackIds;

  Playlist({
    required this.name,
    required this.userId,
    required this.trackIds,
  });

  static Playlist fromJSON(Map<String, dynamic> json) => Playlist(
        name: json["name"],
        userId: json["userId"],
        trackIds: List<String>.from(json["trackIds"]),
      );

  Map<String, dynamic> toJSON() => <String, dynamic>{
        "name": name,
        "userId": userId,
        "trackIds": List<String>.from(trackIds),
      };
}
