import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class LikedSongsSliverAppBar extends SliverAppBar {
  const LikedSongsSliverAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  State<LikedSongsSliverAppBar> createState() => _LikedSongsSliverAppBarState();
}

class _LikedSongsSliverAppBarState extends State<LikedSongsSliverAppBar> {
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

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isCollapsed ? const Text("Liked Songs") : const SizedBox(),
      ),
      expandedHeight: MediaQuery.of(context).size.width,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Hero(
            tag: "liked_songs_icon",
            child: FittedBox(
              fit: BoxFit.cover,
              child: Container(
                width: 56,
                height: 56,
                color: Theme.of(context).primaryColorLight,
                child: AppIcon.primaryColorDark(
                  Icons.favorite_rounded,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      leading: AppIcon(
        Icons.arrow_back_rounded,
        onPressed: Navigator.of(context).pop,
      ),
    );
  }
}
