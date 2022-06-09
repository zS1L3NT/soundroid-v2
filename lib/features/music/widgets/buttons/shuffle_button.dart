import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class ShuffleButton extends StatefulWidget {
  const ShuffleButton({Key? key}) : super(key: key);

  @override
  State<ShuffleButton> createState() => _ShuffleButtonState();
}

class _ShuffleButtonState extends State<ShuffleButton> {
  late final _player = context.read<PlayingProvider>().player;

  void handleClick() {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _player.shuffleModeEnabledStream,
      builder: (context, snap) {
        switch (snap.data) {
          case true:
            return AppIcon.primaryColorDark(
              Icons.shuffle_rounded,
              context,
              onPressed: handleClick,
            );
          case false:
            return AppIcon.primaryColorLight(
              Icons.shuffle_rounded,
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
