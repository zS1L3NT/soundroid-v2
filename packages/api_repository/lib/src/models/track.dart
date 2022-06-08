import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'track.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Track {
  const Track({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final List<Artist> artists;
  @HiveField(3)
  final String thumbnail;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
