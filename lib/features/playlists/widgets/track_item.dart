import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class TrackItem extends StatelessWidget {
  const TrackItem({
    Key? key,
    required this.trackId,
    required this.onTap,
  }) : super(key: key);

  final String trackId;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final currentStream = context.read<MusicProvider>().current;

    return FutureBuilder<Track>(
      future: context.read<ApiRepository>().getTrack(trackId),
      builder: (context, snap) {
        final track = snap.data;

        return StreamBuilder<Track?>(
          stream: currentStream,
          builder: (context, snap) {
            return AppListItem.fromTrack(
              track,
              onTap: onTap,
              onMoreTap: track != null ? () => showTrackBottomSheet(context, track) : null,
              isActive: track == snap.data,
            );
          },
        );
      },
    );
  }
}
