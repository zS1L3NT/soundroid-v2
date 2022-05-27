import 'package:flutter/material.dart';
import 'package:soundroid/helpers/api_helper.dart';
import 'package:soundroid/ui/widgets/main/home/playlists.dart';
import 'package:soundroid/ui/widgets/main/home/section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 1) Your playlists
// 2) Tracks that you've been listening to a lot
// 3) Recommended for you
// 4) More from {artistName}
// 5) Tracks that you don't listen to very often
// 6) More from {artistName}
// 7) More from {artistName}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _futureFeed;

  @override
  void initState() {
    super.initState();

    _futureFeed = ApiHelper.fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureFeed,
      builder: (context, snap) {
        return ListView.builder(
          itemCount: (snap.data?.length ?? 0) + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const PlaylistsSection();
            }
            if (snap.hasError) {
              return Text('Error, ${snap.error}');
            }
            return Section(
              section: snap.data![index - 1],
            );
          },
        );
      },
    );
  }
}
