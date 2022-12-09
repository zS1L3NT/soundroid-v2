// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AlbumCWProxy {
  Album artists(List<Artist> artists);

  Album id(String id);

  Album thumbnail(String thumbnail);

  Album title(String title);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Album(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Album(...).copyWith(id: 12, name: "My name")
  /// ````
  Album call({
    List<Artist>? artists,
    String? id,
    String? thumbnail,
    String? title,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAlbum.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAlbum.copyWith.fieldName(...)`
class _$AlbumCWProxyImpl implements _$AlbumCWProxy {
  final Album _value;

  const _$AlbumCWProxyImpl(this._value);

  @override
  Album artists(List<Artist> artists) => this(artists: artists);

  @override
  Album id(String id) => this(id: id);

  @override
  Album thumbnail(String thumbnail) => this(thumbnail: thumbnail);

  @override
  Album title(String title) => this(title: title);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Album(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Album(...).copyWith(id: 12, name: "My name")
  /// ````
  Album call({
    Object? artists = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? thumbnail = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
  }) {
    return Album(
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

extension $AlbumCopyWith on Album {
  /// Returns a callable class that can be used as follows: `instanceOfAlbum.copyWith(...)` or like so:`instanceOfAlbum.copyWith.fieldName(...)`.
  _$AlbumCWProxy get copyWith => _$AlbumCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['id'] as String,
      title: json['title'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artists': instance.artists,
      'thumbnail': instance.thumbnail,
    };
