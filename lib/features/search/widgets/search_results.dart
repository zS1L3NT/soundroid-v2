import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/search/search.dart';
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
                icon: Icons.music_note_rounded,
                onTap: () {
                  context.read<MusicProvider>().playTrackIds([result.id]);
                },
                onMoreTap: () {
                  AppBottomSheet(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        StreamBuilder<Track?>(
                          stream: context.read<MusicProvider>().current,
                          builder: (context, snap) {
                            return AppListItem.fromTrack(
                              result,
                              onTap: () {
                                context.read<MusicProvider>().playTrackIds([result.id]);
                                Navigator.of(context).pop();
                              },
                              isActive: snap.data == result,
                            );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("Like"),
                          leading: AppIcon.primaryColor(Icons.favorite_rounded, context),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text("Add to playlist"),
                          leading: AppIcon.primaryColor(Icons.playlist_add_rounded, context),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text("Add to queue"),
                          leading: AppIcon.primaryColor(Icons.queue_music_rounded, context),
                          onTap: () {},
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ).show(context);
                },
                isActive: result == snap.data,
              );
            }

            if (result is Album) {
              return AppListItem.fromAlbum(
                result,
                icon: Icons.album_rounded,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AlbumScreen(
                          album: result,
                        );
                      },
                    ),
                  );
                },
              );
            }

            throw Error();
          },
        );
      },
    );
  }
}
