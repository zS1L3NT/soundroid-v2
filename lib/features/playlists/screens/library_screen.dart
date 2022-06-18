import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends KeptAliveState<LibraryScreen> {
  late final _playlistsStream = context.read<PlaylistRepository>().getPlaylists();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<List<Playlist>>(
      stream: _playlistsStream,
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text("Error: ${snap.error}"),
          );
        }

        if (!snap.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snap.data!.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const LikedSongsItem();
            }

            final playlist = snap.data![index - 1];
            return AppListItem.fromPlaylist(
              playlist,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PlaylistScreen(
                        playlist: playlist,
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
