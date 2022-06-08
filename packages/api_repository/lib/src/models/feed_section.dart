import 'models.dart';

abstract class FeedSection {
  abstract final String type;
}

class TrackSection extends FeedSection {
  TrackSection({
    required this.type,
    required this.title,
    required this.description,
    required this.items,
  });

  @override
  final String type;

  final String title;

  final String description;

  final List<Track> items;

  TrackSection.fromJson(Map<String, dynamic> json)
      : type = json["type"],
        title = json["title"],
        description = json["description"],
        items = json["items"].map((item) => Track.fromJson(item)).toList().cast<Track>();
}

class ArtistSection extends FeedSection {
  ArtistSection({
    required this.type,
    required this.artist,
    required this.items,
  });

  @override
  final String type;

  final Artist artist;

  final List<Track> items;

  ArtistSection.fromJson(Map<String, dynamic> json)
      : type = json["type"],
        artist = Artist.fromJson(json["artist"]),
        items = json["items"].map((item) => Track.fromJson(item)).toList().cast<Track>();
}
