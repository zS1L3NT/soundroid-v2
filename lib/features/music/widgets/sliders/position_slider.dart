import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';

class PositionSlider extends StatefulWidget {
  const PositionSlider({Key? key}) : super(key: key);

  @override
  State<PositionSlider> createState() => _PositionSliderState();
}

class _PositionSliderState extends State<PositionSlider> {
  late final _player = context.read<PlayingProvider>().player;
  double _progress = 0.5;

  String formatDuration(Duration? duration) {
    if (duration == null) {
      return "??:??";
    }

    final minutes = "${duration.inMinutes % 60}".padLeft(2, "0");
    final seconds = "${duration.inSeconds % 60}".padLeft(2, "0");

    if (duration.inHours > 0) {
      return "${duration.inHours}:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<Duration>(
          stream: _player.positionStream,
          builder: (context, snap) {
            return Text(
              formatDuration(snap.data),
              style: Theme.of(context).textTheme.caption,
            );
          },
        ),
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 2,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Expanded(
            child: Slider.adaptive(
              value: _progress,
              onChanged: (progress) {
                setState(() {
                  _progress = progress;
                });
              },
            ),
          ),
        ),
        StreamBuilder<Duration?>(
          stream: _player.durationStream,
          builder: (context, snap) {
            return Text(
              formatDuration(snap.data),
              style: Theme.of(context).textTheme.caption,
            );
          },
        ),
      ],
    );
  }
}
