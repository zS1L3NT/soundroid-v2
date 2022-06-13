import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class SkipPreviousButton extends StatelessWidget {
  const SkipPreviousButton({Key? key}) : super(key: key);

  void handleClick(BuildContext context) {
    final player = context.read<PlayingProvider>().player;

    if (player.position.inSeconds >= 2) {
      player.seek(Duration.zero);
    } else {
      player.seekToPrevious();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppIcon.primaryColor(
      Icons.skip_previous_rounded,
      context,
      size: 28,
      splashRadius: 24,
      onPressed: () => handleClick(context),
    );
  }
}
