import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class HorizontalTracks extends StatelessWidget {
  const HorizontalTracks({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Track> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 186,
      child: ShaderMask(
        shaderCallback: (rectangle) => const LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black,
            Colors.black,
            Colors.transparent,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0, 0.05, 0.9, 1],
        ).createShader(rectangle),
        blendMode: BlendMode.dstIn,
        child: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 24),
              for (final track in items) ...[
                SizedBox(
                  width: 125,
                  child: Column(
                    children: [
                      AppImage.network(
                        track.thumbnail,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        size: 128,
                      ),
                      const SizedBox(height: 6),
                      AppText.marquee(
                        track.title,
                        width: 125,
                      ),
                      AppText.marquee(
                        track.artists.map((artist) => artist.name).join(", "),
                        width: 125,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
