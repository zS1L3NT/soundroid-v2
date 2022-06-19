import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/widgets/widgets.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        slivers: [
          AlbumSliverAppBar(
            album: widget.album,
            controller: _controller,
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
                    widget.album.title,
                    extraHeight: 13,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  AppText.marquee(
                    widget.album.artists.map((artist) => artist.name).join(", "),
                    extraHeight: 13,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const Divider()
                ],
              ),
            ),
          ),
          FutureBuilder<List<Track>>(
            future: context.read<ApiRepository>().getAlbumTracks(widget.album.id),
            builder: (context, snap) {
              final tracks = snap.data;

              if (tracks == null) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return StreamBuilder<Track?>(
                stream: context.read<MusicProvider>().current,
                builder: (context, snap) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, int index) {
                        final track = tracks[index];

                        return AppListItem.fromTrack(
                          track,
                          onTap: () {
                            context.read<MusicProvider>().playTrackIds(
                                  tracks.map((track) => track.id).toList(),
                                  index,
                                );
                          },
                          isActive: track == snap.data,
                        );
                      },
                      childCount: tracks.length,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
