import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  const Album({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
  });

  final String id;

  final String title;

  final List<Artist> artists;

  final String thumbnail;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
