import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlaylistSelectAppBar extends AppBar {
  PlaylistSelectAppBar({Key? key}) : super(key: key);

  @override
  State<PlaylistSelectAppBar> createState() => _PlaylistSelectAppBarState();
}

class _PlaylistSelectAppBarState extends State<PlaylistSelectAppBar> {
  void handleCreate() {
    AppTextDialog(
      title: "New Playlist",
      textFieldName: "Playlist name",
      confirmText: "Create",
      onConfirm: (String name) {
        context.read<PlaylistRepository>().addPlaylist(
              Playlist(
                id: context.read<PlaylistRepository>().newId,
                userRef: context.read<AuthenticationRepository>().currentUserRef,
                name: name,
                thumbnail: null,
                favourite: false,
                download: false,
                trackIds: [],
              ),
            );
        Navigator.of(context).pop();
      },
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Choose a playlist"),
      leading: AppIcon(
        Icons.close_rounded,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        AppIcon.white(
          Icons.add_rounded,
          onPressed: handleCreate,
        ),
      ],
    );
  }
}
