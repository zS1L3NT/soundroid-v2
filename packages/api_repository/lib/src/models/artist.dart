import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Artist {
  const Artist({
    required this.id,
    required this.name,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
