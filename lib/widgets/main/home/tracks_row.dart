import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class TracksRow extends StatefulWidget {
  final List<Track> tracks;
  const TracksRow({Key? key, required this.tracks}) : super(key: key);

  @override
  State<TracksRow> createState() => _TracksRowState();
}

class _TracksRowState extends State<TracksRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
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
          stops: [0, 0.01, 0.99, 1],
        ).createShader(rectangle),
        blendMode: BlendMode.dstIn,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 24),
          itemCount: widget.tracks.length,
          itemBuilder: (context, index) {
            final track = widget.tracks[index];
            return SizedBox(
              width: 125,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                  AppText(
                    track.title,
                    height: 26,
                    width: 125,
                    style: const TextStyle(fontSize: 16),
                  ),
                  AppText(
                    track.artists,
                    height: 22,
                    width: 125,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
