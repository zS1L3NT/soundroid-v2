import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlaylistSliverAppBar extends SliverAppBar {
  const PlaylistSliverAppBar({
    Key? key,
    required this.initialPlaylist,
    required this.playlist,
    required this.controller,
  }) : super(key: key);

  final Playlist initialPlaylist;

  final Playlist? playlist;

  final ScrollController controller;

  @override
  State<PlaylistSliverAppBar> createState() => _PlaylistSliverAppBarState();
}

class _PlaylistSliverAppBarState extends State<PlaylistSliverAppBar> {
  late final _playlistId = widget.initialPlaylist.id;
  bool _isHeroComplete = false;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(
      () {
        final isCollapsed = widget.controller.offset > (200 + MediaQuery.of(context).padding.top);
        if (isCollapsed != _isCollapsed) {
          setState(() {
            _isCollapsed = isCollapsed;
          });
        }
      },
    );
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isCollapsed ? Text(widget.playlist?.name ?? "...") : const SizedBox(),
      ),
      expandedHeight: MediaQuery.of(context).size.width,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Builder(
            builder: (context) {
              final thumbnail =
                  _isHeroComplete ? widget.playlist?.thumbnail : widget.initialPlaylist.thumbnail;
              _isHeroComplete = true;

              final hero = Hero(
                tag: "playlist_$_playlistId",
                child: AppImage.network(
                  thumbnail,
                  errorIconPadding: 24,
                ),
              );
              if (thumbnail == null) {
                return hero;
              }
              return FittedBox(
                fit: BoxFit.cover,
                child: hero,
              );
            },
          ),
        ),
      ),
      leading: AppIcon(
        Icons.arrow_back_rounded,
        onPressed: onBackClick,
      ),
      actions: [
        PlaylistPopupMenu(
          playlistId: _playlistId,
          hasThumbnail: widget.playlist?.thumbnail != null,
        ).build(),
      ],
    );
  }
}
