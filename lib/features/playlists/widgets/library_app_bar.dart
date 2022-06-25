import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/widgets/widgets.dart';

class LibraryAppBar extends AppBar {
  LibraryAppBar({Key? key}) : super(key: key);

  @override
  State<LibraryAppBar> createState() => _LibraryAppBarState();
}

class _LibraryAppBarState extends State<LibraryAppBar> {
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
                lastPlayed: null,
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
      title: const Text("Library"),
      actions: [
        AppIcon.white(
          Icons.add_rounded,
          onPressed: handleCreate,
        ),
      ],
    );
  }
}
