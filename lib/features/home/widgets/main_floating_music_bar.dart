import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:music_service/music_service.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class MainFloatingMusicButton extends StatelessWidget {
  const MainFloatingMusicButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final durationStream = context.read<MusicProvider>().player.durationStream;
    // final positionStream = context.read<MusicProvider>().player.positionStream;
    bool isSwipeUp = false;

    return GestureDetector(
      child: SizedBox(
        width: 64,
        height: 64,
        child: Stack(
          children: [
            StreamBuilder<Track?>(
              stream: context.read<MusicService>().current,
              builder: (context, snap) {
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Hero(
                    tag: "current",
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: 60,
                      height: 60,
                      child: AppImage.network(
                        snap.data?.thumbnail,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 64,
              height: 64,
              child: StreamBuilder<Duration?>(
                // stream: durationStream,
                builder: (context, snap) {
                  final duration = snap.data;

                  return StreamBuilder<Duration>(
                    // stream: positionStream,
                    builder: (context, snap) {
                      final position = snap.data;

                      return CircularProgressIndicator(
                        strokeWidth: 3,
                        value: position != null && duration != null
                            ? position.inSeconds / duration.inSeconds
                            : null,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.5),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: const Color.fromRGBO(0, 0, 0, 0.4),
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.of(context).push(
                      PlayingScreen.route(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      onPanUpdate: (details) {
        isSwipeUp = details.delta.dy < 0;
      },
      onPanEnd: (action) {
        if (isSwipeUp) {
          // Show the current playing screen when I swipe up
          Navigator.of(context).push(
            PlayingScreen.route(),
          );
        }
      },
    );
  }
}
