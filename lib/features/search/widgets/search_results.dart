import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/widgets/widgets.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    Key? key,
    required this.results,
  }) : super(key: key);

  final SearchResults results;

  void showBottomSheet(BuildContext context, Track track) {
    AppBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          StreamBuilder<Track?>(
            stream: context.read<MusicProvider>().current,
            builder: (context, snap) {
              return AppListItem.fromTrack(
                track,
                onTap: () {
                  context.read<MusicProvider>().playTrackIds([track.id]);
                  Navigator.of(context).pop();
                },
                isActive: snap.data == track,
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
            onTap: () {
              Navigator.of(context).push(
                PlaylistSelectScreen.route(
                  trackId: track.id,
                  onSelect: (playlist) async {
                    Navigator.of(context).pop();
                    await context.read<PlaylistRepository>().updatePlaylist(
                      playlist.id,
                      {
                        "trackIds": playlist.trackIds + [track.id],
                      },
                    );
                    AppSnackBar(
                      text: "Added track to playlist",
                      icon: Icons.playlist_add_check_rounded,
                    ).show(context);
                  },
                ),
              );
            },
          ),
          if (!context.read<MusicProvider>().queue.tracks.contains(track))
            ListTile(
              title: const Text("Add to queue"),
              leading: AppIcon.primaryColor(Icons.queue_music_rounded, context),
              onTap: () async {
                Navigator.of(context).pop();
                await context.read<MusicProvider>().queue.addTrack(track);
                AppSnackBar(
                  text: "Added track to queue",
                  icon: Icons.playlist_add_check_rounded,
                ).show(context);
              },
            ),
          const SizedBox(height: 8),
        ],
      ),
    ).show(context);
  }

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
                  showBottomSheet(context, result);
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
