import 'models.dart';

class SearchResult {
  final String id;
  final String title;
  final List<Artist> artists;
  final String thumbnail;

  SearchResult({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
  });

  SearchResult.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        artists = json["artists"]
            .cast<Map<String, dynamic>>()
            .map(Artist.fromJson)
            .toList()
            .cast<Artist>(),
        thumbnail = json["thumbnail"];
}
