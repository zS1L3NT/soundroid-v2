import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/utils/kept_alive_state.dart';
import 'package:soundroid/widgets/widgets.dart';

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
  late final _playlistsStream = context.read<PlaylistRepository>().getRecentPlaylists();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      // Call set state in a Future so that the FutureBuilder will rerender
      onRefresh: () => Future(() => setState(() {})),
      child: FutureBuilder<List<FeedSection>>(
        future: context.read<ApiRepository>().getFeed(),
        builder: (context, snap) {
          final sections = snap.data;

          if (snap.hasError && snap.connectionState == ConnectionState.done) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 52 - kToolbarHeight - kToolbarHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon.red(
                        Icons.cloud_off_rounded,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Could not get feed from the\nSounDroid server!",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            );
          }

          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (sections!.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 52 - kToolbarHeight - kToolbarHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon.primaryColor(
                        Icons.music_note_rounded,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Start listening to some music\nso we know what songs to\nrecommend you!",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            );
          }

          return StreamBuilder<List<Playlist>>(
            stream: _playlistsStream,
            builder: (context, snap) {
              final playlists = snap.data;

              return ListView.builder(
                itemCount: sections.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return YourPlaylistsSection(
                      playlists: playlists,
                    );
                  }

                  final section = sections[index - 1];
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
        },
      ),
    );
  }
}
