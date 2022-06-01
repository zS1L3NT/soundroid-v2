import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/models/user.dart';
import 'package:soundroid/ui/screens/playlist.dart';
import 'package:soundroid/ui/widgets/app_widgets.dart';

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
            return AppListItem.fromPlaylist(
              snap.data!.docs[index - 1].data(),
              onTap: () {
                Navigator.of(context).pushNamed(PlaylistScreen.routeName);
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
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Library"),
      elevation: 10,
    );
  }
}
