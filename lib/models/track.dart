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

  Track.fromJson(Map<String, dynamic> json)
      : id = json["id"].toString(),
        title = json["title"].toString(),
        artists = json["artists"].toString(),
        thumbnail = json["thumbnail"].toString();

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "artists": artists,
        "thumbnail": thumbnail,
      };
}
