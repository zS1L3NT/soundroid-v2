import 'package:flutter/material.dart';
import 'package:soundroid/features/music/music.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({Key? key}) : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  final _controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    bool isSwipeDown = false;

    return GestureDetector(
      child: Scaffold(
        appBar: PlayingAppBar(
          controller: _controller,
        ),
        body: PageView(
          scrollBehavior: const ScrollBehavior().copyWith(
            overscroll: false,
            physics: const ClampingScrollPhysics(),
          ),
          controller: _controller,
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
