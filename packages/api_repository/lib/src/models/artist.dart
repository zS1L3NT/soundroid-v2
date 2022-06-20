import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@CopyWith()
@HiveType(typeId: 1)
@JsonSerializable()
class Artist extends Equatable {
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
