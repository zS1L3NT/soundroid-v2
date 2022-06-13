import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late final _player = context.read<MusicProvider>().player;
  late final _queue = context.read<MusicProvider>().queue;
  late final _userStream = context.read<AuthenticationRepository>().currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _userStream,
      builder: (context, snap) {
        final user = snap.data;
        if (user == null) {
          return AppIcon.loading();
        }

        return StreamBuilder<int?>(
          stream: _player.currentIndexStream,
          builder: (context, snap) {
            final current = snap.data != null ? _queue.tracks[snap.data!] : null;
            if (current == null) {
              return AppIcon.loading();
            }

            return AppIcon.primaryColor(
              user.likedTrackIds.contains(current.id)
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
              context,
              onPressed: () {},
            );
          },
        );
      },
    );
  }
}
