import 'package:flutter/material.dart';

class LyricsScreen extends StatefulWidget {
  const LyricsScreen({Key? key}) : super(key: key);

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  late Future<List<String>> _futureLyrics;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<String>>(
        future: _futureLyrics,
        builder: (context, snap) {
          if (snap.hasError) {
            return Text("Error: ${snap.error}");
          }

          if (!snap.hasData) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (context, index) {
              return Text(
                snap.data![index],
                style: const TextStyle(
                  fontSize: 18,
                  height: 2,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
