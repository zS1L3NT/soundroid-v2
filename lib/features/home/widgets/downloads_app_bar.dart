import 'package:flutter/material.dart';

class DownloadsAppBar extends AppBar {
  DownloadsAppBar({Key? key}) : super(key: key);

  @override
  State<DownloadsAppBar> createState() => _DownloadsAppBarState();
}

class _DownloadsAppBarState extends State<DownloadsAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Downloads"),
    );
  }
}
