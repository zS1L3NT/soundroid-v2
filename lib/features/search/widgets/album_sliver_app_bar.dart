import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class AlbumSliverAppBar extends SliverAppBar {
  const AlbumSliverAppBar({
    Key? key,
    required this.album,
    required this.controller,
  }) : super(key: key);

  final Album album;

  final ScrollController controller;

  @override
  State<AlbumSliverAppBar> createState() => _AlbumSliverAppBarState();
}

class _AlbumSliverAppBarState extends State<AlbumSliverAppBar> {
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      final isCollapsed = widget.controller.offset > (200 + MediaQuery.of(context).padding.top);
      if (isCollapsed != _isCollapsed) {
        setState(() => _isCollapsed = isCollapsed);
      }
    });
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
        child: _isCollapsed ? Text(widget.album.title) : const SizedBox(),
      ),
      expandedHeight: MediaQuery.of(context).size.width,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Hero(
              tag: "album_${widget.album.id}",
              child: AppImage.network(
                widget.album.thumbnail,
                errorIconPadding: 24,
              ),
            ),
          ),
        ),
      ),
      leading: AppIcon(
        Icons.arrow_back_rounded,
        onPressed: onBackClick,
      ),
    );
  }
}
