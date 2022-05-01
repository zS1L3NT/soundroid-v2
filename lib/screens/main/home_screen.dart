import 'package:flutter/material.dart';
import 'package:soundroid/widgets/main/home/more_from_artist_section.dart';
import 'package:soundroid/widgets/main/home/rare_listens_section.dart';
import 'package:soundroid/widgets/main/home/recently_repeated_section.dart';
import 'package:soundroid/widgets/main/home/recommended_section.dart';
import 'package:soundroid/widgets/main/home/your_playlists_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 1) Your playlists
// 2) Songs that you've been listening to a lot
// 3) Recommended for you
// 4) More from {artistName}
// 5) Songs that you don't listen to very often
// 6) More from {artistName}
// 7) More from {artistName}
// 8) Recently played songs

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 16),
          YourPlaylistsSection(),
          SizedBox(height: 16),
          RecentlyRepeatedSection(),
          SizedBox(height: 16),
          RecommendedSection(),
          SizedBox(height: 16),
          MoreFromArtistSection(artistId: "UCTUR0sVEkD8T5MlSHqgaI_Q"),
          SizedBox(height: 16),
          RareListensSection(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
