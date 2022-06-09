import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/widgets/widgets.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();

    return ListView.builder(
      itemCount: searchProvider.results!.tracks.length + searchProvider.results!.albums.length,
      itemBuilder: (context, index) {
        final results = [...searchProvider.results!.tracks, ...searchProvider.results!.albums];
        final result = results[index];

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
