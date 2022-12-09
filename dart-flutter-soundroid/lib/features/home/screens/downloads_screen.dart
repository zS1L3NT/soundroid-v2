import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const DownloadsScreen(),
    );
  }

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DownloadsAppBar(),
      body: ListView.builder(
        itemCount: context.watch<DownloadManager>().queue?.length ?? 0,
        itemBuilder: (context, snap) {
          return AppListItem.fromDownloadingTrackId(
            context.watch<DownloadManager>().queue![snap],
          );
        },
      ),
    );
  }
}
