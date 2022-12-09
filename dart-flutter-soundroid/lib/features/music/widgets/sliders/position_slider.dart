import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';

class PositionSlider extends StatefulWidget {
  const PositionSlider({Key? key}) : super(key: key);

  @override
  State<PositionSlider> createState() => _PositionSliderState();
}

class _PositionSliderState extends State<PositionSlider> {
  late final _durationStream = context.read<MusicProvider>().player.durationStream;
  late final _positionStream = context.read<MusicProvider>().player.positionStream;

  /// The position on the slider that the user is currently touching
  double? _slidePosition;

  String formatDuration(Duration? duration) {
    if (duration == null) {
      return "--:--";
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
    return StreamBuilder<Duration?>(
      stream: _durationStream,
      builder: (context, snap) {
        final duration = snap.data;

        return StreamBuilder<Duration>(
          stream: _positionStream,
          builder: (context, snap) {
            final position = snap.data;

            return StreamBuilder<bool>(
              stream: context.read<MusicProvider>().currentIsPlayable,
              builder: (context, snap) {
                final currentIsPlayable = snap.data == true;

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: currentIsPlayable ? 1 : 0.5,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text(
                          formatDuration(
                            // If the user is dragging the slider, show the user's slide position timing instead
                            _slidePosition != null && duration != null
                                ? Duration(
                                    milliseconds:
                                        (duration.inMilliseconds * _slidePosition!).toInt(),
                                  )
                                : position,
                          ),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 2,
                          disabledThumbColor: Theme.of(context).primaryColor,
                          disabledActiveTrackColor: Theme.of(context).primaryColor,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 8),
                        ),
                        child: Expanded(
                          child: Slider.adaptive(
                            // If the user is dragging the slider, show the user's slide position instead
                            value: _slidePosition ??
                                (position != null && duration != null
                                    ? position.inSeconds / duration.inSeconds
                                    : 0),
                            // Change the _slidePosition when the user drags the slider
                            onChanged: currentIsPlayable
                                ? (position) => setState(() => _slidePosition = position)
                                : null,
                            onChangeEnd: (position) {
                              context.read<MusicProvider>().player.seek(
                                    Duration(
                                      milliseconds:
                                          ((duration?.inMilliseconds ?? 0) * position).toInt(),
                                    ),
                                  );
                              // Reset the _slidePosition when the user stops dragging
                              setState(() => _slidePosition = null);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          formatDuration(duration),
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
