import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'search_results.g.dart';

@CopyWith()
@JsonSerializable()
class SearchResults extends Equatable {
  const SearchResults({
    required this.tracks,
    required this.albums,
  });

  final List<Track> tracks;

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
