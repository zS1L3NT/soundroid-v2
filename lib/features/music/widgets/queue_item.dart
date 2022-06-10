import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class QueueItem extends StatelessWidget {
  const QueueItem({
    Key? key,
    required this.track,
    required this.index,
  }) : super(key: key);

  final Track track;

  final int index;

  void handleTap(
    BuildContext context,
    List<Track>? selected,
    Track track,
  ) {
    if (selected == null) {
      // Play the song
    } else {
      if (selected.contains(track)) {
        if (selected.length == 1) {
          context.read<PlayingProvider>().selected = null;
        } else {
          context.read<PlayingProvider>().selected = selected.where((t) => t != track).toList();
        }
      } else {
        context.read<PlayingProvider>().selected = selected.toList()..add(track);
      }
    }
  }

  void handleLongPress(
    BuildContext context,
    List<Track>? selected,
    Track track,
  ) {
    if (selected == null) {
      context.read<PlayingProvider>().selected = [track];
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = context.select<PlayingProvider, List<Track>?>((provider) => provider.selected);

    return InkWell(
      onTap: () => handleTap(context, selected, track),
      onLongPress: () => handleLongPress(context, selected, track),
      child: ListTile(
        tileColor: selected != null && selected.contains(track)
            ? Theme.of(context).highlightColor
            : Colors.transparent,
        leading: AppImage.network(
          track.thumbnail,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          size: 56,
        ),
        title: AppText.ellipse(track.title),
        subtitle: AppText.ellipse(track.artists.map((artist) => artist.name).join(", ")),
        trailing: ReorderableDragStartListener(
          index: index,
          child: AppIcon.black87(
            Icons.drag_handle_rounded,
            onPressed: () {},
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 16),
      ),
    );
  }
}
