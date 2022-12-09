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

          return FutureBuilder<Lyrics>(
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

              final lyrics = snap.data!;
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: StreamBuilder<Duration>(
                  stream: context.read<MusicProvider>().player.positionStream,
                  builder: (context, snap) {
                    final position = snap.data ?? Duration.zero;

                    return ListView.builder(
                      itemCount: lyrics.lines.length,
                      itemBuilder: (context, index) {
                        return Text(
                          lyrics.lines[index],
                          style: TextStyle(
                            fontSize: 17,
                            color: lyrics.times == null
                                ? Theme.of(context).textTheme.bodyText2!.color
                                : position.inSeconds > (lyrics.times![index] - 1)
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).textTheme.bodyText2!.color,
                          ),
                        );
                      },
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
