import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final thumbnail = context.watch<MusicProvider>().currentThumbnail;

    return FutureBuilder<PaletteGenerator>(
      future: thumbnail != null
          ? PaletteGenerator.fromImageProvider(
              NetworkImage(thumbnail),
              maximumColorCount: 1,
            )
          : null,
      builder: (context, snap) {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: size.width * 0.7,
          height: size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (snap.data != null)
                BoxShadow(
                  color: snap.data!.colors.first,
                  spreadRadius: 4,
                  blurRadius: 20,
                )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: "current",
              child: AppImage.network(
                thumbnail,
              ),
            ),
          ),
        );
      },
    );
  }
}
