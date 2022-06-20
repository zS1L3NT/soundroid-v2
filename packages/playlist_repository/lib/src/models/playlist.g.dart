// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaylistCWProxy {
  Playlist download(bool download);

  Playlist favourite(bool favourite);

  Playlist id(String id);

  Playlist name(String name);

  Playlist thumbnail(String? thumbnail);

  Playlist trackIds(List<String> trackIds);

  Playlist userRef(DocumentReference<Object?> userRef);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Playlist(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Playlist(...).copyWith(id: 12, name: "My name")
  /// ````
  Playlist call({
    bool? download,
    bool? favourite,
    String? id,
    String? name,
    String? thumbnail,
    List<String>? trackIds,
    DocumentReference<Object?>? userRef,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlaylist.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlaylist.copyWith.fieldName(...)`
class _$PlaylistCWProxyImpl implements _$PlaylistCWProxy {
  final Playlist _value;

  const _$PlaylistCWProxyImpl(this._value);

  @override
  Playlist download(bool download) => this(download: download);

  @override
  Playlist favourite(bool favourite) => this(favourite: favourite);

  @override
  Playlist id(String id) => this(id: id);

  @override
  Playlist name(String name) => this(name: name);

  @override
  Playlist thumbnail(String? thumbnail) => this(thumbnail: thumbnail);

  @override
  Playlist trackIds(List<String> trackIds) => this(trackIds: trackIds);

  @override
  Playlist userRef(DocumentReference<Object?> userRef) =>
      this(userRef: userRef);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Playlist(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Playlist(...).copyWith(id: 12, name: "My name")
  /// ````
  Playlist call({
    Object? download = const $CopyWithPlaceholder(),
    Object? favourite = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? thumbnail = const $CopyWithPlaceholder(),
    Object? trackIds = const $CopyWithPlaceholder(),
    Object? userRef = const $CopyWithPlaceholder(),
  }) {
    return Playlist(
      download: download == const $CopyWithPlaceholder() || download == null
          ? _value.download
          // ignore: cast_nullable_to_non_nullable
          : download as bool,
      favourite: favourite == const $CopyWithPlaceholder() || favourite == null
          ? _value.favourite
          // ignore: cast_nullable_to_non_nullable
          : favourite as bool,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      thumbnail: thumbnail == const $CopyWithPlaceholder()
          ? _value.thumbnail
          // ignore: cast_nullable_to_non_nullable
          : thumbnail as String?,
      trackIds: trackIds == const $CopyWithPlaceholder() || trackIds == null
          ? _value.trackIds
          // ignore: cast_nullable_to_non_nullable
          : trackIds as List<String>,
      userRef: userRef == const $CopyWithPlaceholder() || userRef == null
          ? _value.userRef
          // ignore: cast_nullable_to_non_nullable
          : userRef as DocumentReference<Object?>,
    );
  }
}

extension $PlaylistCopyWith on Playlist {
  /// Returns a callable class that can be used as follows: `instanceOfPlaylist.copyWith(...)` or like so:`instanceOfPlaylist.copyWith.fieldName(...)`.
  _$PlaylistCWProxy get copyWith => _$PlaylistCWProxyImpl(this);
}
