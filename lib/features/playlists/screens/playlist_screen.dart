import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
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
  late Stream<Playlist?> _playlistStream;
  final _scrollController = ScrollController();
  bool _isHeroComplete = false;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();

    _playlistStream = context.read<PlaylistRepository>().getPlaylist(widget.playlist.id);
    _scrollController.addListener(() {
      final isCollapsed = _scrollController.offset > (200 + MediaQuery.of(context).padding.top);
      if (isCollapsed != _isCollapsed) {
        setState(() {
          _isCollapsed = isCollapsed;
        });
      }
    });
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }

  void onMenuClick() {}

  void onReorderClick() {}

  void onChangePictureClick() {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Change picture"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(Icons.image_rounded),
                    SizedBox(width: 16),
                    Text("Choose from gallery"),
                  ],
                ),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(Icons.photo_camera_rounded),
                    SizedBox(width: 16),
                    Text("Take a picture"),
                  ],
                ),
              ),
              if (widget.playlist.thumbnail != null)
                SimpleDialogOption(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  onPressed: () {
                    context.read<PlaylistRepository>().updatePlaylist(
                      widget.playlist.id,
                      {"thumbnail": null},
                    );
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.delete_rounded),
                      SizedBox(width: 16),
                      Text("Remove picture"),
                    ],
                  ),
                ),
            ],
          );
        },
      );
    });
  }

  void onRenameClick() {
    Future.delayed(Duration.zero, () {
      String name = "";

      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Rename Playlist"),
              content: TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Playlist Name",
                ),
                autofocus: true,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: name.isNotEmpty
                      ? () {
                          context.read<PlaylistRepository>().updatePlaylist(
                            widget.playlist.id,
                            {"name": name},
                          );
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: const Text("Rename"),
                ),
              ],
            );
          });
        },
      );
    });
  }

  void onDeletePlaylistClick() {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete playlist"),
            content: const Text("Are you sure you want to delete this playlist?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                child: const Text("Delete"),
                onPressed: () {
                  context.read<PlaylistRepository>().deletePlaylist(widget.playlist.id);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  void onFavouriteClick() {
    context.read<PlaylistRepository>().updatePlaylist(
      widget.playlist.id,
      {"favourite": !widget.playlist.favourite},
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
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                title: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _isCollapsed ? Text(playlist?.name ?? "...") : const SizedBox(),
                ),
                expandedHeight: MediaQuery.of(context).size.width,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Builder(
                      builder: (context) {
                        final thumbnail =
                            _isHeroComplete ? playlist?.thumbnail : widget.playlist.thumbnail;
                        _isHeroComplete = true;

                        final hero = Hero(
                          tag: "playlist_${widget.playlist.id}",
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
                  PopupMenuButton(
                    child: IconButton(
                      icon: AppIcon.white(Icons.more_vert_rounded),
                      onPressed: null,
                    ),
                    offset: const Offset(0, 55),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              AppIcon.black87(Icons.swap_vert_rounded),
                              const SizedBox(width: 16),
                              const Text("Reorder songs"),
                            ],
                          ),
                          onTap: onReorderClick,
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              AppIcon.black87(Icons.camera_alt_rounded),
                              const SizedBox(width: 16),
                              const Text("Change picture"),
                            ],
                          ),
                          onTap: onChangePictureClick,
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              AppIcon.black87(Icons.edit_rounded),
                              const SizedBox(width: 16),
                              const Text("Rename"),
                            ],
                          ),
                          onTap: onRenameClick,
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              AppIcon.black87(Icons.delete_rounded),
                              const SizedBox(width: 16),
                              const Text("Delete"),
                            ],
                          ),
                          onTap: onDeletePlaylistClick,
                        ),
                      ];
                    },
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
                                  onPressed: onFavouriteClick,
                                )
                              : AppIcon.loading(
                                  color: Colors.black,
                                ),
                          playlist != null
                              ? AppIcon(
                                  playlist.download
                                      ? Icons.download_done_rounded
                                      : Icons.download_rounded,
                                  color: playlist.download ? Theme.of(context).primaryColor : null,
                                  onPressed: onDownloadClick,
                                )
                              : AppIcon.loading(
                                  color: Colors.black,
                                )
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
  late Future<Track> _futureTrack;

  @override
  void initState() {
    super.initState();

    _futureTrack = context.read<ApiRepository>().getTrack(widget.trackId);
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
