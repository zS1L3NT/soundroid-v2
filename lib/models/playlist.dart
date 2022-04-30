class Playlist {
  final String name;
  final String userId;
  final String thumbnail;
  final List<String> trackIds;

  Playlist({
    required this.name,
    required this.userId,
    required this.thumbnail,
    required this.trackIds,
  });

  static Playlist fromJSON(Map<String, dynamic> json) => Playlist(
        name: json["name"],
        userId: json["userId"],
        thumbnail: json["thumbnail"],
        trackIds: List<String>.from(json["trackIds"]),
      );

  Map<String, dynamic> toJSON() => <String, dynamic>{
        "name": name,
        "userId": userId,
        "thumbnail": thumbnail,
        "trackIds": List<String>.from(trackIds),
      };
}
