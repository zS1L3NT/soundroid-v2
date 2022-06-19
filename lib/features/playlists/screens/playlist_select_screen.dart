import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/app_list_item.dart';

class PlaylistSelectScreen extends StatefulWidget {
  const PlaylistSelectScreen({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  static Route route(Function(Playlist) onSelect) {
    return MaterialPageRoute(
      builder: (_) => PlaylistSelectScreen(onSelect: onSelect),
    );
  }

  final Function(Playlist) onSelect;

  @override
  State<PlaylistSelectScreen> createState() => _PlaylistSelectScreenState();
}

class _PlaylistSelectScreenState extends State<PlaylistSelectScreen> {
  late final _playlistsStream = context.read<PlaylistRepository>().getPlaylists();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlaylistSelectAppBar(),
      body: StreamBuilder<List<Playlist>>(
        stream: _playlistsStream,
        builder: (context, snap) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final playlist = snap.data![index];

              return AppListItem.fromPlaylist(
                playlist,
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onSelect(playlist);
                },
              );
            },
            itemCount: snap.data?.length ?? 0,
          );
        },
      ),
    );
  }
}
