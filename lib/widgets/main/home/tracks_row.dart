import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class TracksRow extends StatelessWidget {
  const TracksRow({
    Key? key,
    required this.tracks,
  }) : super(key: key);

  final List<Track> tracks;

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
            Colors.transparent
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
              for (final track in tracks) ...[
                SizedBox(
                  width: 125,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: FadeInImage.memoryNetwork(
                          fadeInCurve: Curves.decelerate,
                          placeholder: kTransparentImage,
                          image: track.thumbnail,
                          fit: BoxFit.cover,
                          width: 125,
                          height: 125,
                        ),
                      ),
                      const SizedBox(height: 6),
                      AppText.marquee(
                        track.title,
                        width: 125,
                      ),
                      AppText.marquee(
                        track.artists,
                        width: 125,
                        fontSize: 14,
                        extraHeight: 8,
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
