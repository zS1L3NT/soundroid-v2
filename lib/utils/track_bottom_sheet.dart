import 'package:api_repository/api_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/widgets.dart';

/// A helper function that shows a bottom sheet with information about
/// a track and some helper buttons.
void showTrackBottomSheet(BuildContext context, Track track) {
  AppBottomSheet(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        AppListItem.fromTrack(
          track,
          onTap: () {
            context.read<MusicProvider>().playTrackIds([track.id]);
            Navigator.of(context).pop();
          },
        ),
        const Divider(),
        StreamBuilder<User?>(
          stream: context.read<AuthenticationRepository>().currentUser,
          builder: (context, snap) {
            final user = snap.data;
            final isLiked = user?.likedTrackIds.contains(track.id);

            return ListTile(
              title: Text(
                isLiked == null
                    ? ".."
                    : isLiked
                        ? "Unlike this track"
                        : "Like this track",
              ),
              leading: isLiked == null
                  ? AppIcon.loading()
                  : AppIcon.primaryColor(
                      isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    ),
              onTap: () {
                if (user == null) return;

                if (isLiked!) {
                  context.read<AuthenticationRepository>().updateUser(
                        user.copyWith.likedTrackIds(
                          user.likedTrackIds.where((trackId) => trackId != track.id).toList(),
                        ),
                      );
                } else {
                  context.read<AuthenticationRepository>().updateUser(
                        user.copyWith.likedTrackIds(
                          user.likedTrackIds + [track.id],
                        ),
                      );
                }
              },
            );
          },
        ),
        ListTile(
          title: const Text("Add to playlist"),
          leading: AppIcon.primaryColor(Icons.playlist_add_rounded),
          onTap: () {
            Navigator.of(context).push(
              PlaylistSelectScreen.route(
                trackId: track.id,
                onSelect: (playlist) async {
                  Navigator.of(context).pop();
                  await context.read<PlaylistRepository>().updatePlaylist(
                        playlist.copyWith.trackIds(
                          playlist.trackIds + [track.id],
                        ),
                      );
                  const AppSnackBar(
                    text: "Added track to playlist",
                    icon: Icons.playlist_add_check_rounded,
                  ).show(context);
                },
              ),
            );
          },
        ),
        if (!context.read<MusicProvider>().queue.tracks.contains(track))
          ListTile(
            title: const Text("Add to queue"),
            leading: AppIcon.primaryColor(Icons.queue_music_rounded),
            onTap: () async {
              Navigator.of(context).pop();
              await context.read<MusicProvider>().queue.addTrack(track);
              const AppSnackBar(
                text: "Added track to queue",
                icon: Icons.playlist_add_check_rounded,
              ).show(context);
            },
          ),
        const SizedBox(height: 8),
      ],
    ),
  ).show(context);
}
