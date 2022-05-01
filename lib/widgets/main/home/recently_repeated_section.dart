import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/main/home/tracks_row.dart';

class RecentlyRepeatedSection extends StatefulWidget {
  const RecentlyRepeatedSection({Key? key}) : super(key: key);

  @override
  State<RecentlyRepeatedSection> createState() =>
      _RecentlyRepeatedSectionState();
}

class _RecentlyRepeatedSectionState extends State<RecentlyRepeatedSection> {
  final List<Track> _tracks = [
    Track(
      id: "",
      title: "Mago",
      artists: "GFRIEND",
      thumbnail:
          "https://thebiaslistcom.files.wordpress.com/2020/11/gfriend-mago.jpg",
    ),
    Track(
      id: "",
      title: "Lilac",
      artists: "IU",
      thumbnail:
          "https://upload.wikimedia.org/wikipedia/en/4/41/IU_-_Lilac.png",
    ),
    Track(
      id: "",
      title: "All About You",
      artists: "Taeyeon",
      thumbnail:
          "https://upload.wikimedia.org/wikipedia/en/e/e1/Taeyeon-All_About_You_%28cover%29.png",
    ),
    Track(
      id: "",
      title: "Can You See My Heart",
      artists: "HEIZE",
      thumbnail:
          "https://i.scdn.co/image/ab67616d0000b273d5ec3d052355298db92ea249",
    ),
    Track(
      id: "",
      title: "strawberry moon",
      artists: "IU",
      thumbnail:
          "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Tracks you listen to a lot",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "A list of tracks that you've heard a lot recently",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(height: 12),
        TracksRow(tracks: _tracks)
      ],
    );
  }
}
