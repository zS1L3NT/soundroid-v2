// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SearchCWProxy {
  Search query(String query);

  Search timestamp(Timestamp timestamp);

  Search userRef(DocumentReference<Object?> userRef);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Search(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Search(...).copyWith(id: 12, name: "My name")
  /// ````
  Search call({
    String? query,
    Timestamp? timestamp,
    DocumentReference<Object?>? userRef,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSearch.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSearch.copyWith.fieldName(...)`
class _$SearchCWProxyImpl implements _$SearchCWProxy {
  final Search _value;

  const _$SearchCWProxyImpl(this._value);

  @override
  Search query(String query) => this(query: query);

  @override
  Search timestamp(Timestamp timestamp) => this(timestamp: timestamp);

  @override
  Search userRef(DocumentReference<Object?> userRef) => this(userRef: userRef);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Search(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Search(...).copyWith(id: 12, name: "My name")
  /// ````
  Search call({
    Object? query = const $CopyWithPlaceholder(),
    Object? timestamp = const $CopyWithPlaceholder(),
    Object? userRef = const $CopyWithPlaceholder(),
  }) {
    return Search(
      query: query == const $CopyWithPlaceholder() || query == null
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String,
      timestamp: timestamp == const $CopyWithPlaceholder() || timestamp == null
          ? _value.timestamp
          // ignore: cast_nullable_to_non_nullable
          : timestamp as Timestamp,
      userRef: userRef == const $CopyWithPlaceholder() || userRef == null
          ? _value.userRef
          // ignore: cast_nullable_to_non_nullable
          : userRef as DocumentReference<Object?>,
    );
  }
}

extension $SearchCopyWith on Search {
  /// Returns a callable class that can be used as follows: `instanceOfSearch.copyWith(...)` or like so:`instanceOfSearch.copyWith.fieldName(...)`.
  _$SearchCWProxy get copyWith => _$SearchCWProxyImpl(this);
}
