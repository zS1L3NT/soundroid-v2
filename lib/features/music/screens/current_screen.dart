import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  Color? _color;

  @override
  void initState() {
    super.initState();

    PaletteGenerator.fromImageProvider(
      const NetworkImage(
        "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
      ),
    ).then((palette) => setState(() => _color = palette.colors.first));

    context.read<PlayingProvider>().queue.addTrack(
          Track(
            id: "sqgxcCjD04s",
            title: "Strawberry Moon",
            artists: [
              const Artist(
                id: "UCTUR0sVEkD8T5MlSHqgaI_Q",
                name: "IU",
              ),
            ],
            thumbnail:
                "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
          ),
        );
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
            const PositionSlider(),
            const Spacer(),
            Row(
              children: const [
                ShuffleButton(),
                Spacer(),
                SkipPreviousButton(),
                Spacer(),
                PlayPauseButton(),
                Spacer(),
                SkipNextButton(),
                Spacer(),
                RepeatButton(),
              ],
            ),
            const Spacer(flex: 3),
            const VolumeSlider(),
          ],
        ),
      ),
    );
  }
}
