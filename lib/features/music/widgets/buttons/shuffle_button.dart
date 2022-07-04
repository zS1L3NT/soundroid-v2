import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundroid/widgets/widgets.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);

  void handleClick(AudioPlayer player) async {
    await player.setShuffleModeEnabled(!player.shuffleModeEnabled);
  }

  @override
  Widget build(BuildContext context) {
    // final player = context.read<MusicProvider>().player;

    return StreamBuilder<bool>(
      // stream: player.shuffleModeEnabledStream,
      builder: (context, snap) {
        switch (snap.data) {
          case true:
            return AppIcon.primaryColorDark(
              Icons.shuffle_rounded,
              // onPressed: () => handleClick(player),
            );
          case false:
            return AppIcon.primaryColorLight(
              Icons.shuffle_rounded,
              // onPressed: () => handleClick(player),
            );
          default:
            return AppIcon.loading();
        }
      },
    );
  }
}
