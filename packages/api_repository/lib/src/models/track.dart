import 'package:api_repository/src/models/models.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

/// Track model returned by the SounDroid API
/// - `@CopyWith`
/// - `@HiveType`
/// - `@JSONSerializable`
/// - `Equatable`
@CopyWith()
@HiveType(typeId: 0)
@JsonSerializable()
class Track extends Equatable {
  const Track({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
  });

  /// The ID of the Track from YouTube
  @HiveField(0)
  final String id;

  /// The title of the Track
  @HiveField(1)
  final String title;

  /// The artists of the Track
  @HiveField(2)
  final List<Artist> artists;

  /// The thumbnail of the Track
  @HiveField(3)
  final String thumbnail;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        artists,
        thumbnail,
      ];

  @override
  String toString() {
    return "Track { $id; $title; ${artists.join(", ")} }";
  }
}
