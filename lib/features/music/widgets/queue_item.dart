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

  void handleTap(MusicProvider musicProvider) {
    musicProvider.player.seek(Duration.zero, index: index);
  }

  @override
  Widget build(BuildContext context) {
    final musicProvider = context.watch<MusicProvider>();

    return StreamBuilder<Track?>(
      stream: musicProvider.current,
      builder: (context, snap) {
        final current = snap.data;

        return Dismissible(
          key: ValueKey(track.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: AppIcon.white(Icons.delete_rounded),
          ),
          onDismissed: (_) {
            musicProvider.queue.removeAt(index);
          },
          child: ListTile(
            onTap: () => handleTap(musicProvider),
            onLongPress: () {},
            leading: AppImage.network(
              track.thumbnail,
              borderRadius: BorderRadius.circular(8),
              size: 56,
            ),
            title: AppText.ellipse(
              track.title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: track == current ? Theme.of(context).primaryColor : null,
                    fontWeight: track == current ? FontWeight.w600 : null,
                  ),
            ),
            subtitle: AppText.ellipse(
              track.artists.map((artist) => artist.name).join(", "),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: track == current ? Theme.of(context).primaryColor : null,
                    fontWeight: track == current ? FontWeight.w600 : null,
                  ),
            ),
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
      },
    );
  }
}
