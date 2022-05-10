import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/playing_provider.dart';

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
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              color: Colors.black,
              splashRadius: 20,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  widget.setIndex(0);
                },
                icon: const Icon(Icons.music_note_rounded),
                color: getColor(0),
                splashRadius: 20,
              ),
              IconButton(
                onPressed: () {
                  widget.setIndex(1);
                },
                icon: const Icon(Icons.queue_music_rounded),
                color: getColor(1),
                splashRadius: 20,
              ),
              IconButton(
                onPressed: () {
                  widget.setIndex(2);
                },
                icon: const Icon(Icons.mic_external_on_rounded),
                color: getColor(2),
                splashRadius: 20,
              ),
            ],
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 10,
            leading: IconButton(
              onPressed: () {
                context.read<PlayingProvider>().selected = null;
              },
              icon: const Icon(Icons.close_rounded),
              splashRadius: 20,
            ),
            title: Text("${selected.length} selected"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_circle_rounded),
                splashRadius: 20,
              ),
            ],
          );
  }
}
