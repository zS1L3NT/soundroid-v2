import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/app_icon.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("SounDroid"),
      actions: [
        if (context.watch<DownloadManager>().queue != null)
          AppIcon.white(
            Icons.download_rounded,
            onPressed: () {
              Navigator.of(context).push(DownloadsScreen.route());
            },
          ),
      ],
    );
  }
}
