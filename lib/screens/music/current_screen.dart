import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:soundroid/constants/app_text_theme.dart';
import 'package:soundroid/widgets/app_widgets.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
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

    final player = AudioPlayer();
    player.play("http://soundroid.zectan.com/download?videoId=sqgxcCjD04s").then((result) {
      print("Result: $result");
    }).catchError((error) {
      print("Error: $error");
    });
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
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      AppText.marquee(
                        "IU",
                        width: size.width,
                        fontSize: 17,
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
                const Text(
                  "2:21",
                  style: AppTextTheme.musicTime,
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
                const Text(
                  "3:39",
                  style: AppTextTheme.musicTime,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                AppIcon.primaryColorLight(
                  Icons.shuffle_rounded,
                  context,
                  onPressed: () {},
                ),
                const Spacer(),
                AppIcon.primaryColor(
                  Icons.skip_previous_rounded,
                  context,
                  size: 28,
                  splashRadius: 24,
                  onPressed: () {},
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
                        onPressed: () {},
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
                  onPressed: () {},
                ),
                const Spacer(),
                AppIcon.primaryColorLight(
                  Icons.repeat_rounded,
                  context,
                  onPressed: () {},
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
