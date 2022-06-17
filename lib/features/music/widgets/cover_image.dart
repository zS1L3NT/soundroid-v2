import 'package:api_repository/api_repository.dart';
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

    return StreamBuilder<Track?>(
      stream: context.read<MusicProvider>().current,
      builder: (context, snap) {
        final current = snap.data;
        return FutureBuilder<PaletteGenerator>(
          future: current?.thumbnail != null
              ? PaletteGenerator.fromImageProvider(
                  NetworkImage(current!.thumbnail),
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
                child: AppImage.network(
                  current?.thumbnail,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
