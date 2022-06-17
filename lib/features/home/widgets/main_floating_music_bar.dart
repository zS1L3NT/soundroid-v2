import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class MainFloatingMusicButton extends StatelessWidget {
  const MainFloatingMusicButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSwipeUp = false;

    return GestureDetector(
      child: SizedBox(
        width: 64,
        height: 64,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.5),
              child: StreamBuilder<Track?>(
                stream: context.watch<MusicProvider>().current,
                builder: (context, snap) {
                  return Hero(
                    tag: "current",
                    child: AppImage.network(
                      snap.data?.thumbnail,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 64,
              height: 64,
              child: StreamBuilder<Duration?>(
                stream: context.watch<MusicProvider>().player.durationStream,
                builder: (context, snap) {
                  final duration = snap.data;
                  return StreamBuilder<Duration>(
                    stream: context.watch<MusicProvider>().player.positionStream,
                    builder: (context, snap) {
                      final position = snap.data;
                      return CircularProgressIndicator(
                        strokeWidth: 3,
                        value: position != null && duration != null
                            ? position.inSeconds / duration.inSeconds
                            : 0,
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
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteTransition.slide(
                        const PlayingScreen(),
                        from: const Offset(0, 1),
                      ),
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
          Navigator.of(context).push(
            RouteTransition.slide(
              const PlayingScreen(),
              from: const Offset(0, 1),
            ),
          );
        }
      },
    );
  }
}
