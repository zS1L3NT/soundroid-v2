import 'package:authentication_repository/authentication_repository.dart';
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
  late final _userStream = context.read<AuthenticationRepository>().currentUser;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<List<Playlist>>(
      stream: context.read<PlaylistRepository>().getPlaylists(),
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
              return ListTile(
                leading: Hero(
                  tag: "liked_songs_icon",
                  child: ClipRRect(
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
                ),
                title: AppText.ellipse("Liked Songs"),
                subtitle: StreamBuilder<User?>(
                  stream: _userStream,
                  builder: (context, snap) {
                    return AppText.ellipse(
                      snap.hasData ? "${snap.data!.likedTrackIds.length} tracks" : "...",
                    );
                  },
                ),
                contentPadding: const EdgeInsets.only(left: 16),
                onTap: () {
                  Navigator.of(context).push(
                    LikedSongsScreen.route(),
                  );
                },
              );
            }

            final playlist = snap.data![index - 1];
            return AppListItem.fromPlaylist(
              playlist,
              onTap: () {
                Navigator.of(context).push(
                  PlaylistScreen.route(playlist),
                );
              },
            );
          },
        );
      },
    );
  }
}
