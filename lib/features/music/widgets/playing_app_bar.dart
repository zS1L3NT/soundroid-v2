import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlayingAppBar extends AppBar {
  PlayingAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<PlayingAppBar> createState() => _PlayingAppBarState();
}

class _PlayingAppBarState extends State<PlayingAppBar> {
  int _page = 1;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      final page = widget.controller.page;

      // Whenever the page changes, if the page is < 20% away from snapping,
      // change the _page variable to change the icon in the appbar.
      if (page != null && (page % 1 > 0.8 || page % 1 < 0.2)) {
        final page = widget.controller.page!.round();
        if (page != _page) {
          setState(() => _page = widget.controller.page!.round());
        }
      }
    });
  }

  void scrollToPage(int page) {
    widget.controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  Color getColor(int index) {
    return _page == index ? Theme.of(context).primaryColor : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final selected = context.select<MusicProvider, List<Track>?>((provider) => provider.selected);

    if (selected == null) {
      return AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: AppIcon.black87(
          Icons.keyboard_arrow_down_rounded,
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          AppIcon(
            Icons.queue_music_rounded,
            color: getColor(0),
            onPressed: () => scrollToPage(0),
          ),
          AppIcon(
            Icons.music_note_rounded,
            color: getColor(1),
            onPressed: () => scrollToPage(1),
          ),
          AppIcon(
            Icons.mic_external_on_rounded,
            color: getColor(2),
            onPressed: () => scrollToPage(2),
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: AppIcon(
          Icons.close_rounded,
          onPressed: () {
            context.read<MusicProvider>().selected = null;
          },
        ),
        title: Text("${selected.length} selected"),
        actions: [
          AppIcon(
            Icons.remove_circle_rounded,
            onPressed: () {},
          ),
        ],
      );
    }
  }
}
