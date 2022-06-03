import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/utils/server.dart';
import 'package:soundroid/widgets/app_widgets.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({
    Key? key,
    required this.playlistId,
  }) : super(key: key);

  final String playlistId;

  static const routeName = "/playlist";

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late Stream<DocumentSnapshot<Playlist>> _playlistStream;

  @override
  void initState() {
    super.initState();

    _playlistStream = Playlist.collection.doc(widget.playlistId).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Playlist>>(
      stream: _playlistStream,
      builder: (context, snap) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: PlaylistHeader(
                  playlist: snap.data?.data(),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 8)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, int index) {
                    final trackId = snap.data!.data()!.trackIds[index];
                    return TrackItem(
                      key: ValueKey(trackId),
                      trackId: trackId,
                    );
                  },
                  childCount: snap.data?.data()?.trackIds.length ?? 0,
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 8)),
            ],
          ),
        );
      },
    );
  }
}

class PlaylistHeader extends SliverPersistentHeaderDelegate {
  final double extendedHeight = 200 - kToolbarHeight;

  const PlaylistHeader({
    Key? key,
    required this.playlist,
  });

  final Playlist? playlist;

  Widget buildPreScroll(
    BuildContext context,
    Color? primaryColorWhiteTween,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          playlist?.thumbnail != null
              ? AppImage.network(
                  playlist!.thumbnail!,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  size: 128,
                )
              : Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const AppIcon(
                    Icons.music_note_rounded,
                    size: 40,
                  ),
                ),
          const SizedBox(width: 16),
          Expanded(
            child: Material(
              color: primaryColorWhiteTween,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.marquee(
                    playlist?.name ?? "...",
                    extraHeight: 12,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText.marquee(
                    "${playlist?.trackIds.length ?? "..."} tracks",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      AppIcon(
                        Icons.favorite_rounded,
                        color: playlist?.favourite == true
                            ? Theme.of(context).primaryColor
                            : Colors.grey[400],
                        onPressed: () {},
                      ),
                      AppIcon(
                        Icons.download_done_rounded,
                        color: playlist?.download == true
                            ? Theme.of(context).primaryColor
                            : Colors.grey[400],
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostScroll(
    BuildContext context,
    double shrinkOffset,
    Color? primaryColorWhiteTween,
    double progress,
  ) {
    final blackWhiteTween = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).lerp(progress);

    return AppBar(
      elevation: 0,
      leading: AppIcon(
        Icons.arrow_back_rounded,
        color: blackWhiteTween,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: (shrinkOffset - 100) > 0 ? 1 : 0,
        child: Text(playlist?.name ?? "..."),
      ),
      actions: [
        AppIcon(
          Icons.more_vert_rounded,
          color: blackWhiteTween,
          onPressed: () {},
        ),
      ],
      backgroundColor: primaryColorWhiteTween,
    );
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = 1 - max(0, extendedHeight - shrinkOffset) / extendedHeight;

    final primaryColorWhiteTween = ColorTween(
      begin: Theme.of(context).scaffoldBackgroundColor,
      end: Theme.of(context).primaryColor,
    ).lerp(progress);

    return Indexer(
      children: [
        Indexed(
          index: progress == 1 ? 3 : 1,
          child: buildPostScroll(
            context,
            shrinkOffset,
            primaryColorWhiteTween,
            progress,
          ),
        ),
        Indexed(
          index: 2,
          child: Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 1 - progress,
              child: buildPreScroll(
                context,
                primaryColorWhiteTween,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extendedHeight + kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class TrackItem extends StatefulWidget {
  const TrackItem({
    Key? key,
    required this.trackId,
  }) : super(key: key);

  final String trackId;

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  late Future<Track> _futureTrack = Server.fetchTrack(widget.trackId);

  @override
  void initState() {
    super.initState();

    _futureTrack = Server.fetchTrack(widget.trackId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Track>(
      future: _futureTrack,
      builder: (context, snap) {
        return AppListItem.fromTrack(
          snap.data,
          onTap: () {},
        );
      },
    );
  }
}
