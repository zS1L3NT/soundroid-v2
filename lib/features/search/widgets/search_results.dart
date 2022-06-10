import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    Key? key,
    required this.results,
  }) : super(key: key);

  final SearchResults results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.tracks.length + results.albums.length,
      itemBuilder: (context, index) {
        final result = [...results.tracks, ...results.albums][index];

        if (result is Track) {
          return AppListItem.fromTrack(result, onTap: () {});
        }

        if (result is Album) {
          return AppListItem.fromAlbum(result, onTap: () {});
        }

        throw Error();
      },
    );
  }
}
