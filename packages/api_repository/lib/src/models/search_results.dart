import 'models.dart';

class SearchResults {
  final List<Track> tracks;
  final List<Album> albums;

  SearchResults.fromJson(Map<String, dynamic> json)
      : tracks = json["tracks"].map((track) => Track.fromJson(track)).toList().cast<Track>(),
        albums = json["albums"].map((album) => Album.fromJson(album)).toList().cast<Album>();
}
