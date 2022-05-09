import 'package:flutter/material.dart';

class PlayingAppBar extends AppBar {
  PlayingAppBar({Key? key}) : super(key: key);

  @override
  State<PlayingAppBar> createState() => _PlayingAppBarState();
}

class _PlayingAppBarState extends State<PlayingAppBar> {
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
          onPressed: () {},
          icon: const Icon(Icons.music_note_rounded),
          color: Theme.of(context).primaryColor,
          splashRadius: 20,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.queue_music_rounded),
          color: Colors.black,
          splashRadius: 20,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.mic_external_on_rounded),
          color: Colors.black,
          splashRadius: 20,
        ),
      ],
    );
  }
}
