import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/widgets.dart';

class TracksReorderScreen extends StatefulWidget {
  const TracksReorderScreen({
    Key? key,
    required this.tracks,
    required this.onFinish,
  }) : super(key: key);

  static Route route({
    required List<Track> tracks,
    required Function(List<Track>) onFinish,
  }) {
    return MaterialPageRoute(
      builder: (_) => TracksReorderScreen(
        tracks: tracks,
        onFinish: onFinish,
      ),
    );
  }

  final List<Track> tracks;

  final Function(List<Track>) onFinish;

  @override
  State<TracksReorderScreen> createState() => _TracksReorderScreenState();
}

class _TracksReorderScreenState extends State<TracksReorderScreen> {
  late final _tracks = widget.tracks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrackReorderAppBar(
        onFinish: () {
          widget.onFinish(_tracks);
        },
      ),
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_tracks[index].id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: AppIcon.white(Icons.delete_rounded),
            ),
            onDismissed: (_) => setState(() => _tracks.removeAt(index)),
            child: AppListItem.fromTrack(
              _tracks[index],
              onTap: () {},
              isDraggable: true,
              dragIndex: index,
            ),
          );
        },
        itemCount: _tracks.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            final track = _tracks.removeAt(oldIndex);
            _tracks.insert(newIndex < oldIndex ? newIndex : newIndex - 1, track);
          });
        },
      ),
    );
  }
}
