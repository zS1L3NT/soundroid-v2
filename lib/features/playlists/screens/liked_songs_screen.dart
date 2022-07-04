import 'package:api_repository/api_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:music_service/music_service.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class LikedSongsScreen extends StatelessWidget {
  const LikedSongsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LikedSongsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthenticationRepository>().currentUser,
        builder: (context, snap) {
          final trackIds = snap.data?.likedTrackIds ?? [];

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            slivers: [
              LikedSongsSliverAppBar(
                controller: controller,
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
                    return FutureBuilder<Track>(
                      future: context.read<ApiRepository>().getTrack(trackIds[index]),
                      builder: (context, snap) {
                        final track = snap.data;

                        return AppListItem.fromTrack(
                          track,
                          onTap: () async {
                            context.read<MusicService>().playTracks(
                                  await Future.wait(
                                    trackIds.map(context.read<ApiRepository>().getTrack),
                                  ),
                                  index,
                                );
                          },
                          onMoreTap:
                              track != null ? () => showTrackBottomSheet(context, track) : null,
                        );
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
