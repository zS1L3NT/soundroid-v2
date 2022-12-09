// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listen.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListenCWProxy {
  Listen timestamp(Timestamp timestamp);

  Listen trackIds(List<String> trackIds);

  Listen userRef(DocumentReference<Object?> userRef);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Listen(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Listen(...).copyWith(id: 12, name: "My name")
  /// ````
  Listen call({
    Timestamp? timestamp,
    List<String>? trackIds,
    DocumentReference<Object?>? userRef,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfListen.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfListen.copyWith.fieldName(...)`
class _$ListenCWProxyImpl implements _$ListenCWProxy {
  final Listen _value;

  const _$ListenCWProxyImpl(this._value);

  @override
  Listen timestamp(Timestamp timestamp) => this(timestamp: timestamp);

  @override
  Listen trackIds(List<String> trackIds) => this(trackIds: trackIds);

  @override
  Listen userRef(DocumentReference<Object?> userRef) => this(userRef: userRef);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Listen(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Listen(...).copyWith(id: 12, name: "My name")
  /// ````
  Listen call({
    Object? timestamp = const $CopyWithPlaceholder(),
    Object? trackIds = const $CopyWithPlaceholder(),
    Object? userRef = const $CopyWithPlaceholder(),
  }) {
    return Listen(
      timestamp: timestamp == const $CopyWithPlaceholder() || timestamp == null
          ? _value.timestamp
          // ignore: cast_nullable_to_non_nullable
          : timestamp as Timestamp,
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

extension $ListenCopyWith on Listen {
  /// Returns a callable class that can be used as follows: `instanceOfListen.copyWith(...)` or like so:`instanceOfListen.copyWith.fieldName(...)`.
  _$ListenCWProxy get copyWith => _$ListenCWProxyImpl(this);
}
