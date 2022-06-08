import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/widgets.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Stream<List<Playlist>> _playlistStream;

  @override
  initState() {
    super.initState();

    _playlistStream = context.read<PlaylistRepository>().getPlaylists();
  }

  Widget buildLikedSongs() {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            width: 56,
            height: 56,
            color: Theme.of(context).primaryColorLight,
            child: AppIcon.primaryColorDark(
              Icons.favorite_rounded,
              context,
              size: 20,
            ),
          ),
        ),
        title: AppText.ellipse("Liked Songs"),
        subtitle: AppText.ellipse("3 tracks"),
        contentPadding: const EdgeInsets.only(left: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Playlist>>(
      stream: _playlistStream,
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
              return buildLikedSongs();
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

class LibraryAppBar extends AppBar {
  LibraryAppBar({Key? key}) : super(key: key);

  @override
  State<LibraryAppBar> createState() => _LibraryAppBarState();
}

class _LibraryAppBarState extends State<LibraryAppBar> {
  void handleAddPlaylist(String name) {
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
  }

  void handleAddPlaylistDialog() {
    String name = "";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("New Playlist"),
              content: TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Playlist Name",
                ),
                autofocus: true,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: name.isNotEmpty ? () => handleAddPlaylist(name) : null,
                  child: const Text("Create"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Library"),
      actions: [
        AppIcon.white(
          Icons.add_rounded,
          onPressed: handleAddPlaylistDialog,
        ),
      ],
    );
  }
}
