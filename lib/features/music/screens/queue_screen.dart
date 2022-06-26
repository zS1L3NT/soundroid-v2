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
  late final _shuffleModeEnabledStream =
      context.read<MusicProvider>().player.shuffleModeEnabledStream;
  late final _sequenceStream = context.read<MusicProvider>().player.sequenceStream;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<bool>(
      stream: _shuffleModeEnabledStream,
      builder: (context, snap) {
        final shuffleModeEnabled = snap.data ?? false;

        return StreamBuilder<List<IndexedAudioSource>?>(
          stream: _sequenceStream,
          builder: (context, snap) {
            final tracks = snap.data?.cast<Track>();
            final shuffleOrder = context.watch<MusicProvider>().player.shuffleIndices!;

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: tracks == null
                  ? const SizedBox()
                  : ReorderableListView.builder(
                      itemBuilder: (context, index) {
                        final track = tracks[shuffleModeEnabled ? shuffleOrder[index] : index];

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
      },
    );
  }
}
