import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  static Route route(Album album) {
    return MaterialPageRoute(
      builder: (_) => AlbumScreen(
        album: album,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStream = context.read<MusicProvider>().current;
    final controller = ScrollController();

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        slivers: [
          AlbumSliverAppBar(
            album: album,
            controller: controller,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                children: [
                  AppText.marquee(
                    album.title,
                    extraHeight: 13,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  AppText.marquee(
                    album.artists.map((artist) => artist.name).join(", "),
                    extraHeight: 13,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const Divider()
                ],
              ),
            ),
          ),
          FutureBuilder<List<String>>(
            future: context.read<ApiRepository>().getAlbumTrackIds(album.id),
            builder: (context, snap) {
              final trackIds = snap.data;

              if (trackIds == null) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, int index) {
                    return FutureBuilder<Track>(
                      future: context.read<ApiRepository>().getTrack(trackIds[index]),
                      builder: (context, snap) {
                        final track = snap.data;

                        return AppListItem.fromTrack(
                          track,
                          onTap: () {
                            context.read<MusicProvider>().playTrackIds(trackIds, index);
                          },
                          onMoreTap:
                              track != null ? () => showTrackBottomSheet(context, track) : null,
                        );
                      },
                    );
                  },
                  childCount: trackIds.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
