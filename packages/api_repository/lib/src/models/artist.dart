import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist {
  const Artist({
    required this.id,
    required this.name,
  });

  final String id;

  final String name;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
