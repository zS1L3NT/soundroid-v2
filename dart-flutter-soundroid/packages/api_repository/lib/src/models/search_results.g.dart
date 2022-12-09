// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_results.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SearchResultsCWProxy {
  SearchResults albums(List<Album> albums);

  SearchResults tracks(List<Track> tracks);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchResults(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchResults(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchResults call({
    List<Album>? albums,
    List<Track>? tracks,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSearchResults.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSearchResults.copyWith.fieldName(...)`
class _$SearchResultsCWProxyImpl implements _$SearchResultsCWProxy {
  final SearchResults _value;

  const _$SearchResultsCWProxyImpl(this._value);

  @override
  SearchResults albums(List<Album> albums) => this(albums: albums);

  @override
  SearchResults tracks(List<Track> tracks) => this(tracks: tracks);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchResults(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchResults(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchResults call({
    Object? albums = const $CopyWithPlaceholder(),
    Object? tracks = const $CopyWithPlaceholder(),
  }) {
    return SearchResults(
      albums: albums == const $CopyWithPlaceholder() || albums == null
          ? _value.albums
          // ignore: cast_nullable_to_non_nullable
          : albums as List<Album>,
      tracks: tracks == const $CopyWithPlaceholder() || tracks == null
          ? _value.tracks
          // ignore: cast_nullable_to_non_nullable
          : tracks as List<Track>,
    );
  }
}

extension $SearchResultsCopyWith on SearchResults {
  /// Returns a callable class that can be used as follows: `instanceOfSearchResults.copyWith(...)` or like so:`instanceOfSearchResults.copyWith.fieldName(...)`.
  _$SearchResultsCWProxy get copyWith => _$SearchResultsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResults _$SearchResultsFromJson(Map<String, dynamic> json) =>
    SearchResults(
      tracks: (json['tracks'] as List<dynamic>)
          .map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
      albums: (json['albums'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultsToJson(SearchResults instance) =>
    <String, dynamic>{
      'tracks': instance.tracks,
      'albums': instance.albums,
    };
