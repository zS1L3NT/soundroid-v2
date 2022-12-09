import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

/// Artist model returned by the SounDroid API
/// - `@CopyWith`
/// - `@HiveType`
/// - `@JSONSerializable`
/// - `Equatable`
@CopyWith()
@HiveType(typeId: 1)
@JsonSerializable()
class Artist extends Equatable {
  const Artist({
    required this.id,
    required this.name,
  });

  /// The ID of the Artist from YouTube
  @HiveField(0)
  final String id;

  /// The name of the Artist
  @HiveField(1)
  final String name;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  @override
  String toString() {
    return "Artist { $id; $name }";
  }
}
