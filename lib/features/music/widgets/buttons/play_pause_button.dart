import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({Key? key}) : super(key: key);

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with SingleTickerProviderStateMixin {
  // late final _player = context.read<MusicProvider>().player;
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
    reverseDuration: const Duration(milliseconds: 400),
  );

  @override
  void initState() {
    super.initState();

    // _player.playingStream.listen((playing) {
    //   if (mounted) {
    //     if (playing) {
    //       _controller.forward();
    //     } else {
    //       _controller.reverse();
    //     }
    //   }
    // });
  }

  void handleClick() {
    // if (_player.playing) {
    //   _player.pause();
    // } else {
    //   _player.play();
    // }
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
          child: StreamBuilder<PlayerState?>(
            // stream: context.read<MusicProvider>().player.playerStateStream,
            builder: (context, snap) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: snap.data == null || snap.data!.processingState == ProcessingState.buffering
                    ? AppIcon.loading(
                        size: 36,
                        strokeWidth: 2,
                      )
                    : IconButton(
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _controller,
                        ),
                        color: Theme.of(context).primaryColor,
                        iconSize: 52,
                        splashRadius: 52,
                        onPressed: handleClick,
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
