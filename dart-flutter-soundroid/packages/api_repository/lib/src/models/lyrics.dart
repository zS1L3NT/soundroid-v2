import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lyrics.g.dart';

/// Lyrics model returned by the SounDroid API
/// - `@CopyWith`
/// - `@JSONSerializable`
/// - `Equatable`
@CopyWith()
@JsonSerializable()
class Lyrics {
  const Lyrics({
    required this.lines,
    required this.times,
  });

  /// The lines of the lyrics
  final List<String> lines;

  /// The number of seconds each lyric appears at
  final List<int>? times;

  factory Lyrics.fromJson(Map<String, dynamic> json) => _$LyricsFromJson(json);
  Map<String, dynamic> toJson() => _$LyricsToJson(this);

  @override
  List<Object?> get props => [
        lines,
        times,
      ];

  @override
  String toString() {
    return "Lyrics { $lines; $times }";
  }
}
