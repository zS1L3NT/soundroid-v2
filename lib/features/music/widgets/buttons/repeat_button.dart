import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);

  void handleClick(AudioPlayer player) async {
    switch (player.loopMode) {
      case LoopMode.off:
        await player.setLoopMode(LoopMode.all);
        break;
      case LoopMode.all:
        await player.setLoopMode(LoopMode.one);
        break;
      case LoopMode.one:
        await player.setLoopMode(LoopMode.off);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = context.read<MusicProvider>().player;

    return StreamBuilder<LoopMode>(
      stream: player.loopModeStream,
      builder: (context, snap) {
        switch (snap.data) {
          case LoopMode.off:
            return AppIcon.primaryColorLight(
              Icons.repeat_rounded,
              context,
              onPressed: () => handleClick(player),
            );
          case LoopMode.all:
            return AppIcon.primaryColorDark(
              Icons.repeat_rounded,
              context,
              onPressed: () => handleClick(player),
            );
          case LoopMode.one:
            return AppIcon.primaryColorDark(
              Icons.repeat_one_rounded,
              context,
              onPressed: () => handleClick(player),
            );
          default:
            return AppIcon.loading();
        }
      },
    );
  }
}
