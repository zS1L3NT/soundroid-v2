import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thumbnail = context.watch<MusicProvider>().currentThumbnail;
    final size = MediaQuery.of(context).size.width * 0.7;

    return FutureBuilder<PaletteGenerator>(
      future: thumbnail != null
          ? Future.delayed(
              const Duration(milliseconds: 500),
              // Fetch the dominant color in the thumbnail
              () => PaletteGenerator.fromImageProvider(
                NetworkImage(thumbnail),
                maximumColorCount: 1,
              ),
            )
          : null,
      builder: (context, snap) {
        final palette = snap.data;

        return StreamBuilder<bool>(
          stream: context.read<MusicProvider>().currentIsPlayable,
          builder: (context, snap) {
            final currentIsPlayable = snap.data == true;

            return Stack(
              children: [
                Hero(
                  tag: "current",
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        if (palette != null && palette.colors.isNotEmpty)
                          // Render the dominant color as a shadow background for the image
                          // to give the app a more interactive feel
                          BoxShadow(
                            color: palette.colors.first,
                            spreadRadius: 4,
                            blurRadius: 20,
                          )
                      ],
                    ),
                    child: AppImage.network(
                      thumbnail,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                FutureBuilder<bool>(
                  future: Future.delayed(Duration.zero, () => true),
                  builder: (context, snap) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: snap.data == true ? (currentIsPlayable ? 0 : 1) : 0,
                      child: Container(
                        width: size,
                        height: size,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppIcon.white(Icons.cloud_off_rounded),
                            const SizedBox(height: 8),
                            const Material(
                              color: Colors.transparent,
                              child: Text(
                                "Go online to continue listening to this track",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
