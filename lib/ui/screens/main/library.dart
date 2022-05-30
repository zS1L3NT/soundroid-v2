import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/ui/screens/playlist.dart';
import 'package:soundroid/ui/widgets/app/list_item.dart';
import 'package:soundroid/ui/widgets/main/library/liked_songs_item.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Stream<QuerySnapshot<Playlist>> _playlistStream;

  @override
  void initState() {
    super.initState();
    _playlistStream = FirebaseFirestore.instance
        .collection("playlists")
        .withConverter<Playlist>(
          fromFirestore: (snap, _) => Playlist.fromJson(snap.data()!),
          toFirestore: (playlist, _) => playlist.toJson(),
        )
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Playlist>>(
      stream: _playlistStream,
      builder: (context, snap) {
        return ListView.builder(
          itemBuilder: (context, index) {
            if (index == 1) {
              return const LikedSongsItem();
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
