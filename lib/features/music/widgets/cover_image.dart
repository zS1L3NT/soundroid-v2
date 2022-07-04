import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:soundroid/widgets/widgets.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thumbnail = ""; // context.watch<MusicProvider>().currentThumbnail;
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
        return Hero(
          tag: "current",
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                if (snap.data != null && snap.data!.colors.isNotEmpty)
                  // Render the dominant color as a shadow background for the image
                  // to give the app a more interactive feel
                  BoxShadow(
                    color: snap.data!.colors.first,
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
        );
      },
    );
  }
}
