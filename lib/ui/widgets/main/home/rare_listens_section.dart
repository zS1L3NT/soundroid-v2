import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/ui/widgets/main/home/tracks_row.dart';

class RareListensSection extends StatefulWidget {
  const RareListensSection({Key? key}) : super(key: key);

  @override
  State<RareListensSection> createState() => _RareListensSectionState();
}

class _RareListensSectionState extends State<RareListensSection> {
  final _tracks = [
    Track(
      id: "",
      title: "NAKKA",
      artists: "IU",
      thumbnail: "https://images.genius.com/d789d2c3131299c6f72313b9622a0527.640x640x1.jpg",
    ),
    Track(
      id: "",
      title: "Remember Me",
      artists: "Gummy",
      thumbnail:
          "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2019/09/Gummy-Hotel-Del-Luna-OST-Part-7.jpg?fit=1000%2C1000&ssl=1",
    ),
    Track(
      id: "",
      title: "Wind",
      artists: "Jung Seung Hwan",
      thumbnail: "https://i.scdn.co/image/ab67616d0000b273cd5441e4b9f4ed4fd28ce835",
    ),
    Track(
      id: "",
      title: "You are so beautiful",
      artists: "Eddy Kim",
      thumbnail: "https://i.scdn.co/image/ab67616d0000b2734c265d6a7481608674c7eb32",
    ),
    Track(
      id: "",
      title: "This Love",
      artists: "Davichi",
      thumbnail:
          "https://c-fa.cdn.smule.com/rs-s33/arr/bc/35/6eb65d0a-f6ab-4630-8064-c7b56fd81466_1024.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Tracks you rarely listen to",
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
            "A list of Tracks you haven't been listening to",
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
