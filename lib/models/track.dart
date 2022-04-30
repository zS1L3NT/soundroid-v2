class Track {
  final String id;
  final String title;
  final String artists;
  final String thumbnail;

  Track({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
  });

  static Track fromJSON(Map<String, dynamic> json) => Track(
        id: json["id"],
        title: json["title"],
        artists: json["artists"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJSON() => <String, dynamic>{
        "id": id,
        "title": title,
        "artists": artists,
        "thumbnail": thumbnail,
      };
}
