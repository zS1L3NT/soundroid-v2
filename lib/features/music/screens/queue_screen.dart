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
  late final _player = context.read<MusicProvider>().player;
  late final _queue = context.read<MusicProvider>().queue;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<List<IndexedAudioSource>?>(
      stream: _player.sequenceStream,
      builder: (context, snap) {
        final tracks = snap.data?.cast<Track>();

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: tracks == null
              ? const SizedBox()
              : ReorderableListView(
                  children: tracks
                      .map((track) => QueueItem(
                            key: ValueKey(track.title),
                            track: track,
                            index: tracks.indexOf(track),
                          ))
                      .toList(),
                  onReorder: (int oldIndex, int newIndex) {
                    _queue.move(oldIndex, newIndex < oldIndex ? newIndex : newIndex - 1);
                  },
                ),
        );
      },
    );
  }
}
