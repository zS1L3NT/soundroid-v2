import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/playing_provider.dart';
import 'package:soundroid/ui/screens/playing/current.dart';
import 'package:soundroid/ui/screens/playing/lyrics.dart';
import 'package:soundroid/ui/screens/playing/queue.dart';
import 'package:soundroid/ui/widgets/app/icon.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({Key? key}) : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  final _screens = const [
    CurrentScreen(),
    QueueScreen(),
    LyricsScreen(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlayingAppBar(
        index: _index,
        setIndex: (index) => setState(() => _index = index),
      ),
      body: _screens[_index],
    );
  }
}

class PlayingAppBar extends AppBar {
  PlayingAppBar({
    Key? key,
    required this.index,
    required this.setIndex,
  }) : super(key: key);

  final int index;

  final Function(int) setIndex;

  @override
  State<PlayingAppBar> createState() => _PlayingAppBarState();
}

class _PlayingAppBarState extends State<PlayingAppBar> {
  Color getColor(int index) {
    return widget.index == index ? Theme.of(context).primaryColor : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<PlayingProvider>().selected;
    return selected == null
        ? AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: AppIcon.black87(
              Icons.keyboard_arrow_down_rounded,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              AppIcon(
                Icons.music_note_rounded,
                color: getColor(0),
                onPressed: () {
                  widget.setIndex(0);
                },
              ),
              AppIcon(
                Icons.queue_music_rounded,
                color: getColor(1),
                onPressed: () {
                  widget.setIndex(1);
                },
              ),
              AppIcon(
                Icons.mic_external_on_rounded,
                color: getColor(2),
                onPressed: () {
                  widget.setIndex(2);
                },
              ),
            ],
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 10,
            leading: AppIcon(
              Icons.close_rounded,
              onPressed: () {
                context.read<PlayingProvider>().selected = null;
              },
            ),
            title: Text("${selected.length} selected"),
            actions: [
              AppIcon(
                Icons.remove_circle_rounded,
                onPressed: () {},
              ),
            ],
          );
  }
}
