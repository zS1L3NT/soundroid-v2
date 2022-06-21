import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';

class PositionSlider extends StatefulWidget {
  const PositionSlider({Key? key}) : super(key: key);

  @override
  State<PositionSlider> createState() => _PositionSliderState();
}

class _PositionSliderState extends State<PositionSlider> {
  double? _slidePosition;

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
    return StreamBuilder<Duration?>(
      stream: context.read<MusicProvider>().player.durationStream,
      builder: (context, snap) {
        final duration = snap.data;

        return StreamBuilder<Duration>(
          stream: context.read<MusicProvider>().player.positionStream,
          builder: (context, snap) {
            final position = snap.data;

            return Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    formatDuration(
                      _slidePosition != null && duration != null
                          ? Duration(
                              milliseconds: (duration.inMilliseconds * _slidePosition!).toInt(),
                            )
                          : position,
                    ),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 2,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 8),
                  ),
                  child: Expanded(
                    child: Slider.adaptive(
                      value: _slidePosition ??
                          (position != null && duration != null
                              ? position.inSeconds / duration.inSeconds
                              : 0),
                      onChanged: (position) {
                        setState(() => _slidePosition = position);
                      },
                      onChangeEnd: (position) {
                        context.read<MusicProvider>().player.seek(
                              Duration(
                                milliseconds: ((duration?.inMilliseconds ?? 0) * position).toInt(),
                              ),
                            );
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
            );
          },
        );
      },
    );
  }
}
