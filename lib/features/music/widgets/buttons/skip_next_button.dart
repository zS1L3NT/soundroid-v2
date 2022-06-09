import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class SkipNextButton extends StatelessWidget {
  const SkipNextButton({Key? key}) : super(key: key);

  void handleClick(BuildContext context) {
    context.read<PlayingProvider>().player.seekToNext();
  }

  @override
  Widget build(BuildContext context) {
    return AppIcon.primaryColor(
      Icons.skip_next_rounded,
      context,
      size: 28,
      splashRadius: 24,
      onPressed: () => handleClick(context),
    );
  }
}
