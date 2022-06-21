import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/app_list_item.dart';

class PlaylistSelectScreen extends StatelessWidget {
  const PlaylistSelectScreen({
    Key? key,
    required this.onSelect,
    required this.trackId,
  }) : super(key: key);

  static Route route({
    required Function(Playlist) onSelect,
    required String trackId,
  }) {
    return MaterialPageRoute(
      builder: (_) => PlaylistSelectScreen(
        onSelect: onSelect,
        trackId: trackId,
      ),
    );
  }

  final Function(Playlist) onSelect;

  final String trackId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlaylistSelectAppBar(),
      body: StreamBuilder<List<Playlist>>(
        stream: context.read<PlaylistRepository>().getPlaylists(),
        builder: (context, snap) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: snap.data == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final playlist = snap.data![index];

                      return AppListItem.fromPlaylist(
                        playlist,
                        onTap: () {
                          Navigator.of(context).pop();
                          onSelect(playlist);
                        },
                        isDisabled: playlist.trackIds.contains(trackId),
                      );
                    },
                    itemCount: snap.data?.length ?? 0,
                  ),
          );
        },
      ),
    );
  }
}
