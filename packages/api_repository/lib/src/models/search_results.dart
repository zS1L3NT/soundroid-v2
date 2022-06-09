import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'search_results.g.dart';

@JsonSerializable()
class SearchResults {
  const SearchResults({
    required this.tracks,
    required this.albums,
  });

  final List<Track> tracks;

  final List<Album> albums;

  factory SearchResults.fromJson(Map<String, dynamic> json) => _$SearchResultsFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultsToJson(this);
}
