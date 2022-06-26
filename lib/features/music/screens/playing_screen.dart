import 'package:flutter/material.dart';
import 'package:soundroid/features/music/music.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const PlayingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 1);
    bool isSwipeDown = false;

    return GestureDetector(
      child: Scaffold(
        appBar: PlayingAppBar(
          controller: controller,
        ),
        body: PageView(
          scrollBehavior: const ScrollBehavior().copyWith(
            overscroll: false,
            physics: const ClampingScrollPhysics(),
          ),
          controller: controller,
          children: const [
            LyricsScreen(),
            CurrentScreen(),
            QueueScreen(),
          ],
        ),
      ),
      onPanUpdate: (details) {
        isSwipeDown = details.delta.dy > 0;
      },
      onPanEnd: (action) {
        if (isSwipeDown) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
