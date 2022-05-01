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
      height: 190,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 16),
          for (var track in widget.tracks)
            Container(
              width: 125,
              margin: const EdgeInsets.only(right: 16),
              child: Material(
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
                    const SizedBox(height: 8),
                    AppText(
                      track.title,
                      height: 30,
                      width: 125,
                      style: const TextStyle(fontSize: 16),
                    ),
                    AppText(
                      track.artists,
                      height: 24,
                      width: 125,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
