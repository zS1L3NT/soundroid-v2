import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<FeedSection>> _futureFeed;
  final _playlists = [];

  Widget buildYourPlaylistsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Playlists",
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 12),
          for (final playlist in _playlists) ...[
            Material(
              elevation: 8,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Row(
                children: [
                  AppImage.networkPlaylistFade(playlist.thumbnail),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppText.marquee(playlist.name),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
          ]
        ],
      ),
    );
  }

  Widget buildHorizontalTrack(dynamic items) {
    return SizedBox(
      height: 186,
      child: ShaderMask(
        shaderCallback: (rectangle) => const LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black,
            Colors.black,
            Colors.transparent,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0, 0.05, 0.9, 1],
        ).createShader(rectangle),
        blendMode: BlendMode.dstIn,
        child: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 24),
              for (final track in items) ...[
                SizedBox(
                  width: 125,
                  child: Column(
                    children: [
                      AppImage.network(
                        track.thumbnail,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        size: 128,
                      ),
                      const SizedBox(height: 6),
                      AppText.marquee(
                        track.title,
                        width: 125,
                      ),
                      AppText.marquee(
                        track.artists.map((artist) => artist.name).join(", "),
                        width: 125,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24)
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTrackSection(TrackSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            section.title,
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            section.description,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        const SizedBox(height: 12),
        buildHorizontalTrack(section.items),
      ],
    );
  }

  Widget buildArtistSection(ArtistSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              AppImage.network(
                null,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                size: 48,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "More from",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    section.artist.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        buildHorizontalTrack(section.items),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              return buildYourPlaylistsSection();
            }

            final section = snap.data![index - 1];
            switch (section.type) {
              case SectionType.track:
                return buildTrackSection(section as TrackSection);
              case SectionType.artist:
                return buildArtistSection(section as ArtistSection);
              default:
                return Text(
                  "Unknown section type: ${section.type}",
                  style: const TextStyle(color: Colors.red),
                );
            }
          },
        );
      },
    );
  }
}

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
    );
  }
}
