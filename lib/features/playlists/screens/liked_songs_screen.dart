import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/playlists/playlists.dart';

class LikedSongsScreen extends StatefulWidget {
  const LikedSongsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LikedSongsScreen(),
    );
  }

  @override
  State<LikedSongsScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends State<LikedSongsScreen> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthenticationRepository>().currentUser,
        builder: (context, snap) {
          final trackIds = snap.data?.likedTrackIds ?? [];

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            slivers: [
              LikedSongsSliverAppBar(
                controller: _controller,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Liked Songs",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, int index) {
                    final trackId = trackIds[index];
                    return TrackItem(
                      key: ValueKey(trackId),
                      trackId: trackId,
                      onTap: () {
                        context.read<MusicProvider>().playTrackIds(trackIds, index);
                      },
                    );
                  },
                  childCount: trackIds.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
