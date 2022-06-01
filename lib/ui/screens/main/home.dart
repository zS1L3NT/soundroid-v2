import 'package:flutter/material.dart';
import 'package:soundroid/helpers/api_helper.dart';
import 'package:soundroid/ui/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

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
  late Future<List<Map<String, dynamic>>> _futureFeed;
  final _playlists = [];

  @override
  void initState() {
    super.initState();

    _futureFeed = ApiHelper.fetchFeed();
  }

  Widget buildYourPlaylistsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Playlists",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          for (final playlist in _playlists) ...[
            Material(
              elevation: 8,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: ShaderMask(
                      shaderCallback: (rectangle) => const LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.5, 1.0],
                      ).createShader(rectangle),
                      blendMode: BlendMode.dstIn,
                      child: FadeInImage.memoryNetwork(
                        fadeInCurve: Curves.decelerate,
                        placeholder: kTransparentImage,
                        image: playlist.thumbnail,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
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
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: FadeInImage.memoryNetwork(
                          fadeInCurve: Curves.decelerate,
                          placeholder: kTransparentImage,
                          image: track.thumbnail,
                          fit: BoxFit.cover,
                          width: 125,
                          height: 125,
                        ),
                      ),
                      const SizedBox(height: 6),
                      AppText.marquee(
                        track.title,
                        width: 125,
                      ),
                      AppText.marquee(
                        track.artistIds,
                        width: 125,
                        fontSize: 14,
                        extraHeight: 8,
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

  Widget buildTrackSection(Map<String, dynamic> section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            section["title"],
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            section["description"],
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(height: 12),
        buildHorizontalTrack(section["items"]),
      ],
    );
  }

  Widget buildArtistSection(Map<String, dynamic> section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: FadeInImage.memoryNetwork(
                  fadeInCurve: Curves.decelerate,
                  placeholder: kTransparentImage,
                  image: section["artist"]["picture"],
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "More from ",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                section["artist"]["name"],
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        buildHorizontalTrack(section["items"]),
      ],
    );
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
              return buildYourPlaylistsSection();
            }
            if (snap.hasError) {
              return Text('Error, ${snap.error}');
            }
            final section = snap.data![index - 1];
            switch (section["type"]) {
              case "track":
                return buildTrackSection(section);
              case "artist":
                return buildArtistSection(section);
              default:
                return Text(
                  "Unknown section type: " + section["type"],
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
      elevation: 10,
    );
  }
}
