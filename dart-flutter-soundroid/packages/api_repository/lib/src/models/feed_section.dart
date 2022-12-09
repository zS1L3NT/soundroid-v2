import 'package:api_repository/src/models/models.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_section.g.dart';

@JsonEnum()
enum SectionType {
  track,
  artist,
}

abstract class FeedSection extends Equatable {
  /// The type of the section
  abstract final SectionType type;
}

/// Track Section model returned by the SounDroid API
/// - `@CopyWith`
/// - `@JSONSerializable`
/// - `Equatable`
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

  /// The title of the Track Section
  final String title;

  /// The description of the Track Section
  final String description;

  /// The items in the Track Section
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

/// Artist Section model returned by the SounDroid API
/// - `@CopyWith`
/// - `@JSONSerializable`
/// - `Equatable`
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

  /// The artist of the Artist Section
  final Artist artist;

  /// The items in the Artist Section
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
