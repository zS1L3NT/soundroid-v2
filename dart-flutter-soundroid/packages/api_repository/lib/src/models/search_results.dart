import 'package:api_repository/src/models/models.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_results.g.dart';

/// Search Results model returned by the SounDroid API
/// - `@CopyWith`
/// - `@JSONSerializable`
/// - `Equatable`
@CopyWith()
@JsonSerializable()
class SearchResults extends Equatable {
  const SearchResults({
    required this.tracks,
    required this.albums,
  });

  /// The tracks returned by the Search Results
  final List<Track> tracks;

  /// The albums returned by the Search Results
  final List<Album> albums;

  factory SearchResults.fromJson(Map<String, dynamic> json) => _$SearchResultsFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultsToJson(this);

  @override
  List<Object?> get props => [
        tracks,
        albums,
      ];

  @override
  String toString() {
    return "SearchResults { $tracks; $albums }";
  }
}
