import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final Playlist playlist;

  static Route route(Playlist playlist) {
    return MaterialPageRoute(
      builder: (_) => PlaylistScreen(
        playlist: playlist,
      ),
    );
  }

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late final _playlistStream = context.read<PlaylistRepository>().getPlaylist(widget.playlist.id);
  final _controller = ScrollController();

  void onFavouriteClick(bool favourite) {
    context.read<PlaylistRepository>().updatePlaylist(
          widget.playlist.copyWith.favourite(
            !widget.playlist.favourite,
          ),
        );
  }

  void onDownloadClick() {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Playlist?>(
      stream: _playlistStream,
      builder: (context, snap) {
        final playlist = snap.data;
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            slivers: [
              PlaylistSliverAppBar(
                initialPlaylist: widget.playlist,
                playlist: playlist,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppText.marquee(
                              playlist?.name ?? "...",
                              extraHeight: 13,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          playlist != null
                              ? AppIcon(
                                  playlist.favourite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: playlist.favourite ? Theme.of(context).primaryColor : null,
                                  onPressed: () => onFavouriteClick(playlist.favourite),
                                )
                              : AppIcon.loading(color: Colors.black),
                          playlist != null
                              ? AppIcon(
                                  playlist.download
                                      ? Icons.download_done_rounded
                                      : Icons.download_rounded,
                                  color: playlist.download ? Theme.of(context).primaryColor : null,
                                  onPressed: onDownloadClick,
                                )
                              : AppIcon.loading(color: Colors.black)
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, int index) {
                    final trackId = snap.data!.trackIds[index];
                    return TrackItem(
                      key: ValueKey(trackId),
                      trackId: trackId,
                      onTap: () {
                        context.read<MusicProvider>().playTrackIds(snap.data!.trackIds, index);
                      },
                    );
                  },
                  childCount: snap.data?.trackIds.length ?? 0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
