import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:soundroid/widgets/playing/app_bar.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({Key? key}) : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PlayingAppBar(),
      body: Center(
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
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
                  ),
                ),
              ),
              const Spacer(flex: 2),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_rounded),
                    color: Theme.of(context).primaryColor,
                    splashRadius: 20,
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_rounded),
                    color: Theme.of(context).primaryColor,
                    splashRadius: 20,
                  ),
                ],
              ),
              const Spacer(flex: 3),
              Row(
                children: [
                  const Text(
                    "2:21",
                    style: TextStyle(fontSize: 12),
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
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shuffle_rounded),
                    color: Theme.of(context).primaryColorLight,
                    splashRadius: 20,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous_rounded),
                    color: Theme.of(context).primaryColor,
                    iconSize: 28,
                    splashRadius: 24,
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
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow_rounded),
                          color: Theme.of(context).primaryColor,
                          iconSize: 56,
                          splashRadius: 56,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next_rounded),
                    color: Theme.of(context).primaryColor,
                    iconSize: 28,
                    splashRadius: 24,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.repeat_rounded),
                    color: Theme.of(context).primaryColorLight,
                    splashRadius: 20,
                  ),
                ],
              ),
              const Spacer(flex: 3),
              Row(
                children: [
                  Icon(
                    Icons.volume_up_rounded,
                    size: 20,
                    color: Theme.of(context).primaryColor,
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
                  Icon(
                    Icons.volume_up_rounded,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
