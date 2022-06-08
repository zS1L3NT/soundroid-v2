import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:soundroid/widgets/widgets.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  final _player = AudioPlayer();
  final _queue = ConcatenatingAudioSource(children: []);
  Color? _color;
  double _progress = 0.5;
  double _volume = 1;

  @override
  void initState() {
    super.initState();

    PaletteGenerator.fromImageProvider(
      const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
      ),
    ).then((palette) => setState(() => _color = palette.colors.first));

    _player.setAudioSource(_queue);
    _queue.add(
      AudioSource.uri(
        Uri.parse("http://soundroid.zectan.com/api/download?videoId=sqgxcCjD04s"),
      ),
    );
  }

  void onRepeatClick() {
    switch (_player.loopMode) {
      case LoopMode.off:
        _player.setLoopMode(LoopMode.all);
        break;
      case LoopMode.all:
        _player.setLoopMode(LoopMode.one);
        break;
      case LoopMode.one:
        _player.setLoopMode(LoopMode.off);
        break;
    }
  }

  void onSkipBackClick() {
    _player.seekToPrevious();
  }

  void onPlayPauseClick() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  void onSkipNextClick() {
    _player.seekToNext();
  }

  void onShuffleClick() {}

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
    final size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: _color ?? Colors.transparent,
                    spreadRadius: 12,
                    blurRadius: 16,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage.network(
                  "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
                ),
              ),
            ),
            const Spacer(flex: 2),
            Row(
              children: [
                AppIcon.primaryColor(
                  Icons.favorite_rounded,
                  context,
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      AppText.marquee(
                        "Strawberry Moon",
                        width: size.width,
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      AppText.marquee(
                        "IU",
                        width: size.width,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                AppIcon.primaryColor(
                  Icons.add_rounded,
                  context,
                  onPressed: () {},
                ),
              ],
            ),
            const Spacer(flex: 3),
            Row(
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
            ),
            const Spacer(),
            Row(
              children: [
                StreamBuilder<bool>(
                  stream: _player.shuffleModeEnabledStream,
                  builder: (context, snap) {
                    switch (snap.data) {
                      case true:
                        return AppIcon.primaryColorDark(
                          Icons.shuffle_rounded,
                          context,
                          onPressed: onShuffleClick,
                        );
                      case false:
                        return AppIcon.primaryColorLight(
                          Icons.shuffle_rounded,
                          context,
                          onPressed: onShuffleClick,
                        );
                      default:
                        return AppIcon.loading();
                    }
                  },
                ),
                const Spacer(),
                AppIcon.primaryColor(
                  Icons.skip_previous_rounded,
                  context,
                  size: 28,
                  splashRadius: 24,
                  onPressed: onSkipBackClick,
                ),
                const Spacer(),
                Stack(
                  children: [
                    Container(
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
                      child: AppIcon.primaryColor(
                        Icons.play_arrow_rounded,
                        context,
                        size: 56,
                        splashRadius: 56,
                        onPressed: onPlayPauseClick,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AppIcon.primaryColor(
                  Icons.skip_next_rounded,
                  context,
                  size: 28,
                  splashRadius: 24,
                  onPressed: onSkipNextClick,
                ),
                const Spacer(),
                StreamBuilder<LoopMode>(
                  stream: _player.loopModeStream,
                  builder: (context, snap) {
                    switch (snap.data) {
                      case LoopMode.off:
                        return AppIcon.primaryColorLight(
                          Icons.repeat_rounded,
                          context,
                          onPressed: onRepeatClick,
                        );
                      case LoopMode.all:
                        return AppIcon.primaryColorDark(
                          Icons.repeat_rounded,
                          context,
                          onPressed: onRepeatClick,
                        );
                      case LoopMode.one:
                        return AppIcon.primaryColorDark(
                          Icons.repeat_one_rounded,
                          context,
                          onPressed: onRepeatClick,
                        );
                      default:
                        return AppIcon.loading();
                    }
                  },
                ),
              ],
            ),
            const Spacer(flex: 3),
            Row(
              children: [
                AppIcon.primaryColor(
                  Icons.volume_down_rounded,
                  context,
                  size: 20,
                ),
                SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 1,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                  ),
                  child: Expanded(
                    child: Slider.adaptive(
                      value: _volume,
                      onChanged: (volume) {
                        setState(() {
                          _volume = volume;
                        });
                      },
                    ),
                  ),
                ),
                AppIcon.primaryColorLight(
                  Icons.volume_up_rounded,
                  context,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
