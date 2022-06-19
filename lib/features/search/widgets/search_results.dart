import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    Key? key,
    required this.results,
  }) : super(key: key);

  final SearchResults results;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Track?>(
      stream: context.read<MusicProvider>().current,
      builder: (context, snap) {
        return ListView.builder(
          itemCount: results.tracks.length + results.albums.length,
          itemBuilder: (context, index) {
            final result = [...results.tracks, ...results.albums][index];

            if (result is Track) {
              return AppListItem.fromTrack(
                result,
                onTap: () {},
                isActive: result == snap.data,
              );
            }

            if (result is Album) {
              return AppListItem.fromAlbum(
                result,
                onTap: () {},
              );
            }

            throw Error();
          },
        );
      },
    );
  }
}
