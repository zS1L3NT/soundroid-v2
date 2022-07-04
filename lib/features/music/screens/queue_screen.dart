import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class QueueScreen extends StatefulWidget {
  const QueueScreen({Key? key}) : super(key: key);

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends KeptAliveState<QueueScreen> {
  // late final _shuffleModeEnabledStream =
  //     context.read<MusicProvider>().player.shuffleModeEnabledStream;
  // late final _sequenceStream = context.read<MusicProvider>().player.sequenceStream;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<bool>(
      // stream: _shuffleModeEnabledStream,
      builder: (context, snap) {
        final shuffleModeEnabled = snap.data ?? false;

        return StreamBuilder<List<IndexedAudioSource>?>(
          // stream: _sequenceStream,
          builder: (context, snap) {
            final tracks = snap.data?.cast<Track>();
            // final shuffleOrder = context.watch<MusicProvider>().player.shuffleIndices!;

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: tracks == null
                  ? const SizedBox()
                  : ReorderableListView.builder(
                      itemBuilder: (context, index) {
                        final track = tracks[index];
                        // final track = tracks[shuffleModeEnabled ? shuffleOrder[index] : index];

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
                            // context.read<MusicProvider>().queue?.removeAt(index);
                          },
                          child: AppListItem.fromTrack(
                            track,
                            key: ValueKey(track.id),
                            onTap: () {
                              // context
                              //     .read<MusicProvider>()
                              //     .player
                              //     .seek(Duration.zero, index: index);
                            },
                            isDraggable: true,
                            dragIndex: index,
                          ),
                        );
                      },
                      itemCount: tracks.length,
                      onReorder: (int oldIndex, int newIndex) {
                        // context.read<MusicProvider>().queue?.move(
                        //       oldIndex,
                        //       newIndex < oldIndex ? newIndex : newIndex - 1,
                        //     );
                      },
                    ),
            );
          },
        );
      },
    );
  }
}
