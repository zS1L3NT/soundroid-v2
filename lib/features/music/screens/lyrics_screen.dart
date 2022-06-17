import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/utils/utils.dart';

class LyricsScreen extends StatefulWidget {
  const LyricsScreen({Key? key}) : super(key: key);

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends KeptAliveState<LyricsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<Track?>(
        stream: context.read<MusicProvider>().current,
        builder: (context, snap) {
          final current = snap.data;

          return FutureBuilder<List<String>>(
            future: current != null ? context.read<ApiRepository>().getLyrics(current) : null,
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
                      fontSize: 17,
                      height: 2,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
