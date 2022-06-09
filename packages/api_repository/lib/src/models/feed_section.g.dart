// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackSection _$TrackSectionFromJson(Map<String, dynamic> json) => TrackSection(
      type: $enumDecode(_$SectionTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackSectionToJson(TrackSection instance) =>
    <String, dynamic>{
      'type': _$SectionTypeEnumMap[instance.type],
      'title': instance.title,
      'description': instance.description,
      'items': instance.items,
    };

const _$SectionTypeEnumMap = {
  SectionType.track: 'track',
  SectionType.artist: 'artist',
};

ArtistSection _$ArtistSectionFromJson(Map<String, dynamic> json) =>
    ArtistSection(
      type: $enumDecode(_$SectionTypeEnumMap, json['type']),
      artist: Artist.fromJson(json['artist'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistSectionToJson(ArtistSection instance) =>
    <String, dynamic>{
      'type': _$SectionTypeEnumMap[instance.type],
      'artist': instance.artist,
      'items': instance.items,
    };
