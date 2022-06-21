import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class TrackReorderItem extends StatelessWidget {
  const TrackReorderItem({
    Key? key,
    required this.track,
    required this.index,
  }) : super(key: key);

  final Track track;

  final int index;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Track?>(
      stream: context.read<MusicProvider>().current,
      builder: (context, snap) {
        final current = snap.data;
        return ListTile(
          leading: AppImage.network(
            track.thumbnail,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
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
        );
      },
    );
  }
}
