import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/utils/kept_alive_state.dart';

// 1) Your playlists
// 2) Tracks that you've been listening to a lot
// 3) Recommended for you
// 4) More from {artistName}
// 5) Tracks that you don't listen to very often
// 6) More from {artistName}
// 7) More from {artistName}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends KeptAliveState<HomeScreen> {
  late final _futureFeed = context.read<ApiRepository>().getFeed();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<List<FeedSection>>(
      future: _futureFeed,
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text('Error: ${snap.error}'),
          );
        }

        if (!snap.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snap.data!.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return YourPlaylistsSection();
            }

            final section = snap.data![index - 1];
            switch (section.type) {
              case SectionType.track:
                return TrackSectionWidget(section: section as TrackSection);
              case SectionType.artist:
                return ArtistSectionWidget(section: section as ArtistSection);
            }
          },
        );
      },
    );
  }
}
