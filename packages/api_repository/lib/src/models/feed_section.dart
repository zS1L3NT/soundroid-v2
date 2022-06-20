import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'feed_section.g.dart';

@JsonEnum()
enum SectionType {
  track,
  artist,
}

abstract class FeedSection extends Equatable {
  abstract final SectionType type;
}

@CopyWith()
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

  @override
  List<Object?> get props => [type, title, description, items];

  @override
  String toString() {
    return "TrackSection { $type; $title; $description; ${items.join(", ")} }";
  }
}

@CopyWith()
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

  @override
  List<Object?> get props => [
        type,
        artist,
        items,
      ];

  @override
  String toString() {
    return "ArtistSection { $type; $artist; ${items.join(", ")} }";
  }
}
