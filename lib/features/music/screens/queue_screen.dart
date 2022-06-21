import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/utils/utils.dart';

class QueueScreen extends StatefulWidget {
  const QueueScreen({Key? key}) : super(key: key);

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends KeptAliveState<QueueScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<List<IndexedAudioSource>?>(
      stream: context.read<MusicProvider>().player.sequenceStream,
      builder: (context, snap) {
        final tracks = snap.data?.cast<Track>();

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: tracks == null
              ? const SizedBox()
              : ReorderableListView.builder(
                  itemBuilder: (context, index) {
                    final track = tracks[index];

                    return QueueItem(
                      key: ValueKey(track.id),
                      track: track,
                      index: index,
                    );
                  },
                  itemCount: tracks.length,
                  onReorder: (int oldIndex, int newIndex) {
                    context.read<MusicProvider>().queue.move(
                          oldIndex,
                          newIndex < oldIndex ? newIndex : newIndex - 1,
                        );
                  },
                ),
        );
      },
    );
  }
}
