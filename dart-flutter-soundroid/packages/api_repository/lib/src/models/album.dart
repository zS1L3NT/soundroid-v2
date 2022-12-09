import 'package:api_repository/src/models/models.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

/// Album model returned by the SounDroid API
/// - `@CopyWith`
/// - `@JSONSerializable`
/// - `Equatable`
@CopyWith()
@JsonSerializable()
class Album extends Equatable {
  const Album({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
  });

  /// The ID of the Album from YouTube
  final String id;

  /// The title of the Album
  final String title;

  /// The artists of the Album
  final List<Artist> artists;

  /// The thumbnail of the Album
  final String thumbnail;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        artists,
        thumbnail,
      ];

  @override
  String toString() {
    return "Album { $id; $title; ${artists.join(", ")} }";
  }
}
