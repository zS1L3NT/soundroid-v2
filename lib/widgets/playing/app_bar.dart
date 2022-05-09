import 'package:flutter/material.dart';

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
    return AppBar(
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
    );
  }
}
