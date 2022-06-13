import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({Key? key}) : super(key: key);

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with SingleTickerProviderStateMixin {
  late final _player = context.read<MusicProvider>().player;
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
    reverseDuration: const Duration(milliseconds: 400),
  );

  @override
  void initState() {
    super.initState();

    _player.playingStream.listen((playing) {
      if (mounted) {
        if (playing) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      }
    });
  }

  void handleClick() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(64),
            border: Border.all(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 16,
              ),
            ],
          ),
          child: IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _controller,
            ),
            color: Theme.of(context).primaryColor,
            iconSize: 52,
            splashRadius: 52,
            onPressed: handleClick,
          ),
        ),
      ],
    );
  }
}
