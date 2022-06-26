import 'package:api_repository/api_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserStream = context.read<AuthenticationRepository>().currentUser;
    final currentStream = context.read<MusicProvider>().current;

    return StreamBuilder<User?>(
      stream: currentUserStream,
      builder: (context, snap) {
        final user = snap.data;

        if (user == null) {
          return AppIcon.loading();
        }

        return StreamBuilder<Track?>(
          stream: currentStream,
          builder: (context, snap) {
            final current = snap.data;

            if (current == null) {
              return AppIcon.loading();
            }

            return AppIcon.primaryColor(
              user.likedTrackIds.contains(current.id)
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
              context,
              onPressed: () {
                if (user.likedTrackIds.contains(current.id)) {
                  context.read<AuthenticationRepository>().updateUser(
                        user.copyWith.likedTrackIds(
                          user.likedTrackIds.where((trackId) => trackId != current.id).toList(),
                        ),
                      );
                } else {
                  context.read<AuthenticationRepository>().updateUser(
                        user.copyWith.likedTrackIds(
                          user.likedTrackIds + [current.id],
                        ),
                      );
                }
              },
            );
          },
        );
      },
    );
  }
}
