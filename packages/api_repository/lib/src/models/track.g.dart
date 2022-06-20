// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TrackCWProxy {
  Track artists(List<Artist> artists);

  Track id(String id);

  Track thumbnail(String thumbnail);

  Track title(String title);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Track(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Track(...).copyWith(id: 12, name: "My name")
  /// ````
  Track call({
    List<Artist>? artists,
    String? id,
    String? thumbnail,
    String? title,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTrack.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTrack.copyWith.fieldName(...)`
class _$TrackCWProxyImpl implements _$TrackCWProxy {
  final Track _value;

  const _$TrackCWProxyImpl(this._value);

  @override
  Track artists(List<Artist> artists) => this(artists: artists);

  @override
  Track id(String id) => this(id: id);

  @override
  Track thumbnail(String thumbnail) => this(thumbnail: thumbnail);

  @override
  Track title(String title) => this(title: title);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Track(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Track(...).copyWith(id: 12, name: "My name")
  /// ````
  Track call({
    Object? artists = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? thumbnail = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
  }) {
    return Track(
      artists: artists == const $CopyWithPlaceholder() || artists == null
          ? _value.artists
          // ignore: cast_nullable_to_non_nullable
          : artists as List<Artist>,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      thumbnail: thumbnail == const $CopyWithPlaceholder() || thumbnail == null
          ? _value.thumbnail
          // ignore: cast_nullable_to_non_nullable
          : thumbnail as String,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
    );
  }
}

extension $TrackCopyWith on Track {
  /// Returns a callable class that can be used as follows: `instanceOfTrack.copyWith(...)` or like so:`instanceOfTrack.copyWith.fieldName(...)`.
  _$TrackCWProxy get copyWith => _$TrackCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackAdapter extends TypeAdapter<Track> {
  @override
  final int typeId = 0;

  @override
  Track read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Track(
      id: fields[0] as String,
      title: fields[1] as String,
      artists: (fields[2] as List).cast<Artist>(),
      thumbnail: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Track obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artists)
      ..writeByte(3)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      id: json['id'] as String,
      title: json['title'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnail: json['thumbnail'] as String,
    )..duration = json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int);

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'duration': instance.duration?.inMicroseconds,
      'id': instance.id,
      'title': instance.title,
      'artists': instance.artists,
      'thumbnail': instance.thumbnail,
    };
