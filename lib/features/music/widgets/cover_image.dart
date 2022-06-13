import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class CoverImage extends StatefulWidget {
  const CoverImage({Key? key}) : super(key: key);

  @override
  State<CoverImage> createState() => _CoverImageState();
}

class _CoverImageState extends State<CoverImage> {
  late final _player = context.read<PlayingProvider>().player;
  late final _queue = context.read<PlayingProvider>().queue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder<int?>(
      stream: _player.currentIndexStream,
      builder: (context, snap) {
        final current = snap.data != null ? _queue.tracks[snap.data!] : null;

        return FutureBuilder<PaletteGenerator>(
          future: PaletteGenerator.fromImageProvider(
            NetworkImage(
              current?.thumbnail ?? "",
            ),
            maximumColorCount: 1,
          ),
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
