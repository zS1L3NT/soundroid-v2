import 'package:flutter/material.dart';
import 'package:soundroid/helpers/api_helper.dart';
import 'package:soundroid/models/track.dart';

class LyricsScreen extends StatefulWidget {
  const LyricsScreen({Key? key}) : super(key: key);

  @override
  State<LyricsScreen> createState() => LyricsScreenState();
}

class LyricsScreenState extends State<LyricsScreen> {
  late Future<List<String>> _futureLyrics;

  @override
  void initState() {
    super.initState();

    _futureLyrics = ApiHelper.fetchLyrics(Track(
      id: "sqgxcCjD04s",
      title: "Strawberry Moon",
      artistIds: ["IU"],
      thumbnail: "",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _futureLyrics,
      builder: (context, snap) {
        if (snap.hasData) {
          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (context, index) {
              final lyric = snap.data![index];
              return Center(
                child: Text(
                  lyric,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 2,
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
