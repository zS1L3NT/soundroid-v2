// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LyricsCWProxy {
  Lyrics lines(List<String> lines);

  Lyrics times(List<int>? times);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Lyrics(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Lyrics(...).copyWith(id: 12, name: "My name")
  /// ````
  Lyrics call({
    List<String>? lines,
    List<int>? times,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLyrics.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLyrics.copyWith.fieldName(...)`
class _$LyricsCWProxyImpl implements _$LyricsCWProxy {
  final Lyrics _value;

  const _$LyricsCWProxyImpl(this._value);

  @override
  Lyrics lines(List<String> lines) => this(lines: lines);

  @override
  Lyrics times(List<int>? times) => this(times: times);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Lyrics(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Lyrics(...).copyWith(id: 12, name: "My name")
  /// ````
  Lyrics call({
    Object? lines = const $CopyWithPlaceholder(),
    Object? times = const $CopyWithPlaceholder(),
  }) {
    return Lyrics(
      lines: lines == const $CopyWithPlaceholder() || lines == null
          ? _value.lines
          // ignore: cast_nullable_to_non_nullable
          : lines as List<String>,
      times: times == const $CopyWithPlaceholder()
          ? _value.times
          // ignore: cast_nullable_to_non_nullable
          : times as List<int>?,
    );
  }
}

extension $LyricsCopyWith on Lyrics {
  /// Returns a callable class that can be used as follows: `instanceOfLyrics.copyWith(...)` or like so:`instanceOfLyrics.copyWith.fieldName(...)`.
  _$LyricsCWProxy get copyWith => _$LyricsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lyrics _$LyricsFromJson(Map<String, dynamic> json) => Lyrics(
      lines: (json['lines'] as List<dynamic>).map((e) => e as String).toList(),
      times: (json['times'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$LyricsToJson(Lyrics instance) => <String, dynamic>{
      'lines': instance.lines,
      'times': instance.times,
    };
