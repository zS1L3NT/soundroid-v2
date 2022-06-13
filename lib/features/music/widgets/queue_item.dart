import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class QueueItem extends StatefulWidget {
  const QueueItem({
    Key? key,
    required this.track,
    required this.index,
  }) : super(key: key);

  final Track track;

  final int index;

  @override
  State<QueueItem> createState() => _QueueItemState();
}

class _QueueItemState extends State<QueueItem> {
  late final _musicProvider = context.read<MusicProvider>();

  void handleTap(List<Track>? selected) {
    if (selected == null) {
      // Play the song
    } else {
      if (selected.contains(widget.track)) {
        if (selected.length == 1) {
          _musicProvider.selected = null;
        } else {
          _musicProvider.selected = selected.where((t) => t != widget.track).toList();
        }
      } else {
        _musicProvider.selected = selected.toList()..add(widget.track);
      }
    }
  }

  void handleLongPress(List<Track>? selected) {
    if (selected == null) {
      _musicProvider.selected = [widget.track];
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = context.select<MusicProvider, List<Track>?>((provider) => provider.selected);

    return InkWell(
      onTap: () => handleTap(selected),
      onLongPress: () => handleLongPress(selected),
      child: StreamBuilder<Track?>(
        stream: _musicProvider.current,
        builder: (context, snap) {
          final current = snap.data;
          return ListTile(
            tileColor: selected != null && selected.contains(widget.track)
                ? Theme.of(context).highlightColor
                : Colors.transparent,
            leading: AppImage.network(
              widget.track.thumbnail,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              size: 56,
            ),
            title: AppText.ellipse(widget.track.title),
            textColor: widget.track.id == current?.id ? Theme.of(context).primaryColor : null,
            subtitle: AppText.ellipse(widget.track.artists.map((artist) => artist.name).join(", ")),
            trailing: ReorderableDragStartListener(
              index: widget.index,
              child: AppIcon.black87(
                Icons.drag_handle_rounded,
                onPressed: () {},
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 16),
          );
        },
      ),
    );
  }
}
