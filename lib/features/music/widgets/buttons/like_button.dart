import 'package:api_repository/api_repository.dart';
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

        return StreamBuilder<Track?>(
          stream: context.read<MusicProvider>().current,
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
              onPressed: () {},
            );
          },
        );
      },
    );
  }
}
