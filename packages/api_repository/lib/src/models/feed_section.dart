import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'feed_section.g.dart';

@JsonEnum()
enum SectionType {
  track,
  artist,
}

abstract class FeedSection {
  abstract final SectionType type;
}

@JsonSerializable()
class TrackSection extends FeedSection {
  TrackSection({
    required this.type,
    required this.title,
    required this.description,
    required this.items,
  });

  @override
  final SectionType type;

  final String title;

  final String description;

  final List<Track> items;

  factory TrackSection.fromJson(Map<String, dynamic> json) => _$TrackSectionFromJson(json);
  Map<String, dynamic> toJson() => _$TrackSectionToJson(this);
}

@JsonSerializable()
class ArtistSection extends FeedSection {
  ArtistSection({
    required this.type,
    required this.artist,
    required this.items,
  });

  @override
  final SectionType type;

  final Artist artist;

  final List<Track> items;

  factory ArtistSection.fromJson(Map<String, dynamic> json) => _$ArtistSectionFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistSectionToJson(this);
}
