import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class RepeatButton extends StatefulWidget {
  const RepeatButton({Key? key}) : super(key: key);

  @override
  State<RepeatButton> createState() => _RepeatButtonState();
}

class _RepeatButtonState extends State<RepeatButton> {
  late final _player = context.read<MusicProvider>().player;

  void handleClick() async {
    switch (_player.loopMode) {
      case LoopMode.off:
        await _player.setLoopMode(LoopMode.all);
        break;
      case LoopMode.all:
        await _player.setLoopMode(LoopMode.one);
        break;
      case LoopMode.one:
        await _player.setLoopMode(LoopMode.off);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoopMode>(
      stream: _player.loopModeStream,
      builder: (context, snap) {
        switch (snap.data) {
          case LoopMode.off:
            return AppIcon.primaryColorLight(
              Icons.repeat_rounded,
              context,
              onPressed: handleClick,
            );
          case LoopMode.all:
            return AppIcon.primaryColorDark(
              Icons.repeat_rounded,
              context,
              onPressed: handleClick,
            );
          case LoopMode.one:
            return AppIcon.primaryColorDark(
              Icons.repeat_one_rounded,
              context,
              onPressed: handleClick,
            );
          default:
            return AppIcon.loading();
        }
      },
    );
  }
}
