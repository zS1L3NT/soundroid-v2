import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/providers/playing_provider.dart';
import 'package:soundroid/ui/widgets/app/icon.dart';
import 'package:soundroid/ui/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class QueueListItem extends StatefulWidget {
  const QueueListItem({
    Key? key,
    required this.index,
    required this.track,
  }) : super(key: key);

  final int index;

  final Track track;

  @override
  State<QueueListItem> createState() => _QueueListItemState();
}

class _QueueListItemState extends State<QueueListItem> {
  void onTap(BuildContext context) {
    final selected = context.read<PlayingProvider>().selected;
    if (selected == null) {
      // Play the song
    } else {
      if (selected.contains(widget.track)) {
        if (selected.length == 1) {
          context.read<PlayingProvider>().selected = null;
        } else {
          context.read<PlayingProvider>().selected =
              selected.where((t) => t != widget.track).toList();
        }
      } else {
        context.read<PlayingProvider>().selected = selected.toList()..add(widget.track);
      }
    }
  }

  void onLongPress(BuildContext context) {
    final selected = context.read<PlayingProvider>().selected;
    if (selected == null) {
      context.read<PlayingProvider>().selected = [widget.track];
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<PlayingProvider>().selected;
    return InkWell(
      onTap: () => onTap(context),
      onLongPress: () => onLongPress(context),
      child: ListTile(
        tileColor: selected != null && selected.contains(widget.track)
            ? Theme.of(context).highlightColor
            : Colors.transparent,
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: FadeInImage.memoryNetwork(
            fadeInCurve: Curves.decelerate,
            placeholder: kTransparentImage,
            image: widget.track.thumbnail,
            fit: BoxFit.cover,
            width: 56,
            height: 56,
          ),
        ),
        title: AppText.ellipse(widget.track.title),
        subtitle: AppText.ellipse(widget.track.artistIds.join(", ")),
        trailing: ReorderableDragStartListener(
          index: widget.index,
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
