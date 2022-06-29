import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/utils/utils.dart';
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
      itemBuilder: (context, index) {
        final result = [...results.tracks, ...results.albums][index];

        if (result is Track) {
          return AppListItem.fromTrack(
            result,
            icon: Icons.music_note_rounded,
            onTap: () {
              context.read<MusicProvider>().playTrackIds([result.id]);
            },
            onMoreTap: () {
              showTrackBottomSheet(context, result);
            },
          );
        }

        if (result is Album) {
          return AppListItem.fromAlbum(
            result,
            icon: Icons.album_rounded,
            onTap: () {
              Navigator.of(context).push(
                AlbumScreen.route(result),
              );
            },
          );
        }

        throw Error();
      },
      itemCount: results.tracks.length + results.albums.length,
    );
  }
}
