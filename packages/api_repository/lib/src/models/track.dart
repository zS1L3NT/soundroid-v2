import 'package:hive/hive.dart';

import 'models.dart';

part 'track.g.dart';

@HiveType(typeId: 0)
class Track {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final List<Artist> artists;
  @HiveField(3)
  final String thumbnail;

  Track({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
  });

  Track.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        artists = json["artists"]
            .cast<Map<String, dynamic>>()
            .map(Artist.fromJson)
            .toList()
            .cast<Artist>(),
        thumbnail = json["thumbnail"];
}
