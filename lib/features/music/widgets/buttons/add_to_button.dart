import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/widgets.dart';

class AddToButton extends StatelessWidget {
  const AddToButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Track?>(
      stream: context.read<MusicProvider>().current,
      builder: (context, snap) {
        final current = snap.data;

        if (current == null) {
          return AppIcon.loading();
        }

        return AppIcon.primaryColor(
          Icons.add_rounded,
          context,
          onPressed: () {
            Navigator.of(context).push(
              PlaylistSelectScreen.route(
                onSelect: (playlist) async {
                  await context.read<PlaylistRepository>().updatePlaylist(
                        playlist.copyWith.trackIds(
                          playlist.trackIds + [current.id],
                        ),
                      );
                  AppSnackBar(
                    text: "Added track to playlist",
                    icon: Icons.playlist_add_check_rounded,
                  ).show(context);
                },
                trackId: current.id,
              ),
            );
          },
        );
      },
    );
  }
}
