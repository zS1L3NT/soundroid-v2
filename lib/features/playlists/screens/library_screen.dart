import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/features/playlists/screens/playlist_screen.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/models/user.dart';
import 'package:soundroid/widgets/app_widgets.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _playlistStream = Playlist.collection
      .where("userRef", isEqualTo: User.collection.doc("jnbZI9qOLtVsehqd6ICcw584ED93"))
      .snapshots();

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
    return StreamBuilder<QuerySnapshot<Playlist>>(
      stream: _playlistStream,
      builder: (context, snap) {
        return ListView.builder(
          itemCount: (snap.data?.docs.length ?? 0) + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return buildLikedSongs();
            }
            final doc = snap.data!.docs[index - 1];
            return AppListItem.fromPlaylist(
              doc.id,
              doc.data(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PlaylistScreen(
                        document: doc,
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
    final doc = Playlist.collection.doc();
    doc.set(
      Playlist(
        id: doc.id,
        userRef: User.collection.doc("jnbZI9qOLtVsehqd6ICcw584ED93"),
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
