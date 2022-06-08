import 'models.dart';

class Album {
  final String id;
  final String title;
  final List<Artist> artists;
  final String thumbnail;

  Album.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        artists = json["artists"]
            .cast<Map<String, dynamic>>()
            .map(Artist.fromJson)
            .toList()
            .cast<Artist>(),
        thumbnail = json["thumbnail"];
}
