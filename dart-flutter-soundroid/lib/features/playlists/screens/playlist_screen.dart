import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({
    Key? key,
    required this.playlist,
    required this.heroTag,
  }) : super(key: key);

  final Playlist playlist;

  final String heroTag;

  static Route route(Playlist playlist, String heroTag) {
    return MaterialPageRoute(
      builder: (_) => PlaylistScreen(
        playlist: playlist,
        heroTag: heroTag,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Scaffold(
      body: StreamBuilder<Playlist?>(
        stream: context.read<PlaylistRepository>().getPlaylist(playlist.id),
        builder: (context, snap) {
          final playlist = snap.data;
          final downloaded = context.select<DownloadManager, int?>(
            (manager) => playlist?.trackIds.where(manager.downloaded.contains).length,
          );

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            slivers: [
              PlaylistSliverAppBar(
                initialPlaylist: this.playlist,
                playlist: playlist,
                controller: controller,
                heroTag: heroTag,
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
                                  onPressed: () =>
                                      context.read<PlaylistRepository>().updatePlaylist(
                                            playlist.copyWith.favourite(
                                              !playlist.favourite,
                                            ),
                                          ),
                                )
                              : AppIcon.loading(color: Colors.black),
                          playlist != null
                              ? playlist.download
                                  ? playlist.trackIds.length == downloaded!
                                      ? AppIcon.primaryColor(
                                          Icons.download_done_rounded,
                                          onPressed: () =>
                                              context.read<PlaylistRepository>().updatePlaylist(
                                                    playlist.copyWith.download(
                                                      !playlist.download,
                                                    ),
                                                  ),
                                        )
                                      : AppIcon.loading(
                                          value: downloaded / playlist.trackIds.length,
                                          onTap: () =>
                                              context.read<PlaylistRepository>().updatePlaylist(
                                                    playlist.copyWith.download(
                                                      !playlist.download,
                                                    ),
                                                  ),
                                        )
                                  : AppIcon.primaryColor(
                                      Icons.download_rounded,
                                      onPressed: () =>
                                          context.read<PlaylistRepository>().updatePlaylist(
                                                playlist.copyWith.download(
                                                  !playlist.download,
                                                ),
                                              ),
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
                    return FutureBuilder<Track>(
                      future: context.read<ApiRepository>().getTrack(playlist!.trackIds[index]),
                      builder: (context, snap) {
                        final track = snap.data;

                        return AppListItem.fromTrack(
                          track,
                          onTap: () {
                            context.read<PlaylistRepository>().updatePlaylist(
                                  playlist.copyWith.lastPlayed(PlaylistRepository.now),
                                );
                            context.read<MusicProvider>().playTrackIds(playlist.trackIds, index);
                          },
                          onMoreTap:
                              track != null ? () => showTrackBottomSheet(context, track) : null,
                        );
                      },
                    );
                  },
                  childCount: playlist?.trackIds.length ?? 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
