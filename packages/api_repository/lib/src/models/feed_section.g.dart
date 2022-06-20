// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_section.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TrackSectionCWProxy {
  TrackSection description(String description);

  TrackSection items(List<Track> items);

  TrackSection title(String title);

  TrackSection type(SectionType type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TrackSection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TrackSection(...).copyWith(id: 12, name: "My name")
  /// ````
  TrackSection call({
    String? description,
    List<Track>? items,
    String? title,
    SectionType? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTrackSection.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTrackSection.copyWith.fieldName(...)`
class _$TrackSectionCWProxyImpl implements _$TrackSectionCWProxy {
  final TrackSection _value;

  const _$TrackSectionCWProxyImpl(this._value);

  @override
  TrackSection description(String description) =>
      this(description: description);

  @override
  TrackSection items(List<Track> items) => this(items: items);

  @override
  TrackSection title(String title) => this(title: title);

  @override
  TrackSection type(SectionType type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TrackSection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TrackSection(...).copyWith(id: 12, name: "My name")
  /// ````
  TrackSection call({
    Object? description = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return TrackSection(
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as String,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<Track>,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as SectionType,
    );
  }
}

extension $TrackSectionCopyWith on TrackSection {
  /// Returns a callable class that can be used as follows: `instanceOfTrackSection.copyWith(...)` or like so:`instanceOfTrackSection.copyWith.fieldName(...)`.
  _$TrackSectionCWProxy get copyWith => _$TrackSectionCWProxyImpl(this);
}

abstract class _$ArtistSectionCWProxy {
  ArtistSection artist(Artist artist);

  ArtistSection items(List<Track> items);

  ArtistSection type(SectionType type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistSection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistSection(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistSection call({
    Artist? artist,
    List<Track>? items,
    SectionType? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfArtistSection.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfArtistSection.copyWith.fieldName(...)`
class _$ArtistSectionCWProxyImpl implements _$ArtistSectionCWProxy {
  final ArtistSection _value;

  const _$ArtistSectionCWProxyImpl(this._value);

  @override
  ArtistSection artist(Artist artist) => this(artist: artist);

  @override
  ArtistSection items(List<Track> items) => this(items: items);

  @override
  ArtistSection type(SectionType type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistSection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistSection(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistSection call({
    Object? artist = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return ArtistSection(
      artist: artist == const $CopyWithPlaceholder() || artist == null
          ? _value.artist
          // ignore: cast_nullable_to_non_nullable
          : artist as Artist,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<Track>,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as SectionType,
    );
  }
}

extension $ArtistSectionCopyWith on ArtistSection {
  /// Returns a callable class that can be used as follows: `instanceOfArtistSection.copyWith(...)` or like so:`instanceOfArtistSection.copyWith.fieldName(...)`.
  _$ArtistSectionCWProxy get copyWith => _$ArtistSectionCWProxyImpl(this);
}

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
