import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  final _scrollController = ScrollController();
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();

    _playlistStream = Playlist.collection.doc(widget.playlistId).snapshots();
    _scrollController.addListener(() {
      final isCollapsed = _scrollController.offset > (200 + MediaQuery.of(context).padding.top);
      if (isCollapsed != _isCollapsed) {
        setState(() {
          _isCollapsed = isCollapsed;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Playlist>>(
      stream: _playlistStream,
      builder: (context, snap) {
        final playlist = snap.data?.data();
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                title: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _isCollapsed ? Text(playlist?.name ?? "...") : const SizedBox(),
                ),
                expandedHeight: MediaQuery.of(context).size.width * 0.8,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Image.network(
                    playlist!.thumbnail!,
                    fit: BoxFit.cover,
                  ),
                ),
                leading: AppIcon(
                  Icons.arrow_back_rounded,
                  onPressed: () {},
                ),
                actions: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isCollapsed
                        ? AppIcon(
                            Icons.edit_rounded,
                            onPressed: () {},
                          )
                        : const SizedBox(),
                  ),
                ],
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
                              playlist.name,
                              extraHeight: 13,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          AppIcon(
                            Icons.favorite_rounded,
                            onPressed: () {},
                          ),
                          AppIcon(
                            Icons.download_done_rounded,
                            onPressed: () {},
                          ),
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
                    final trackId = snap.data!.data()!.trackIds[index];
                    return TrackItem(
                      key: ValueKey(trackId),
                      trackId: trackId,
                    );
                  },
                  childCount: snap.data?.data()?.trackIds.length ?? 0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
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
