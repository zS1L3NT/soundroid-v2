import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/main/home/tracks_row.dart';

class RecommendedSection extends StatefulWidget {
  const RecommendedSection({Key? key}) : super(key: key);

  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  final List<Track> _tracks = [
    Track(
      id: "",
      title: "Weekend",
      artists: "Taeyeon",
      thumbnail:
          "https://upload.wikimedia.org/wikipedia/en/d/d8/Taeyeon_%E2%80%93_Weekend.jpg",
    ),
    Track(
      id: "",
      title: "Blueming",
      artists: "IU",
      thumbnail: "https://i.imgur.com/dWQxywe.jpg",
    ),
    Track(
      id: "",
      title: "Twenty Three",
      artists: "IU",
      thumbnail:
          "https://i1.sndcdn.com/artworks-000175236496-6h62ef-t500x500.jpg",
    ),
    Track(
      id: "",
      title: "INVU",
      artists: "Taeyeon",
      thumbnail:
          "https://i.scdn.co/image/ab67616d0000b273034c3a8ba89c6a5ecfda3175",
    ),
    Track(
      id: "",
      title: "Voltage",
      artists: "ITZY",
      thumbnail:
          "https://i.scdn.co/image/ab67616d0000b273aecb87fd2574ad79b05cc024",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Recommended for You",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16),
          child: Text(
            "A list of Tracks we think you might like",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        TracksRow(tracks: _tracks)
      ],
    );
  }
}
