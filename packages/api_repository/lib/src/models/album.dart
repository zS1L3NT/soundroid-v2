import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'album.g.dart';

@CopyWith()
@JsonSerializable()
class Album extends Equatable {
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
