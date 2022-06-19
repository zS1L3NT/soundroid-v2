import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlaylistSelectAppBar extends AppBar {
  PlaylistSelectAppBar({Key? key}) : super(key: key);

  @override
  State<PlaylistSelectAppBar> createState() => _PlaylistSelectAppBarState();
}

class _PlaylistSelectAppBarState extends State<PlaylistSelectAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Choose a playlist"),
      leading: AppIcon(
        Icons.close_rounded,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
