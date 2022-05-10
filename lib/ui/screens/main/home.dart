import 'package:flutter/material.dart';
import 'package:soundroid/ui/widgets/main/home/more_from_artist_section.dart';
import 'package:soundroid/ui/widgets/main/home/rare_listens_section.dart';
import 'package:soundroid/ui/widgets/main/home/recently_repeated_section.dart';
import 'package:soundroid/ui/widgets/main/home/recommended_section.dart';
import 'package:soundroid/ui/widgets/main/home/your_playlists_section.dart';

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
  final _widgets = const [
    YourPlaylistsSection(),
    RecentlyRepeatedSection(),
    RecommendedSection(),
    MoreFromArtistSection(artistId: "UCTUR0sVEkD8T5MlSHqgaI_Q"),
    RareListensSection(),
    MoreFromArtistSection(artistId: "UCwzCuKxyMY_sT7hr1E8G1XA"),
    MoreFromArtistSection(artistId: "UCTP45_DE3fMLujU8sZ-MBzw"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 12),
            for (final widget in _widgets) ...[
              widget,
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}
