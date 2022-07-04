import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class LyricsScreen extends StatefulWidget {
  const LyricsScreen({Key? key}) : super(key: key);

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends KeptAliveState<LyricsScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Center(
      child: StreamBuilder<Track?>(
        stream: context.read<MusicProvider>().current,
        builder: (context, snap) {
          final current = snap.data;

          return FutureBuilder<List<String>>(
            future: current != null ? context.read<ApiRepository>().getLyrics(current) : null,
            builder: (context, snap) {
              if (snap.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon.red(
                      Icons.cloud_off_rounded,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Could not fetch lyrics from the\nSounDroid server!",
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }

              if (!snap.hasData) {
                return const CircularProgressIndicator();
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ListView.separated(
                  itemCount: snap.data!.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
