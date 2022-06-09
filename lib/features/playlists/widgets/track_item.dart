import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/widgets/widgets.dart';

class TrackItem extends StatefulWidget {
  const TrackItem({
    Key? key,
    required this.trackId,
  }) : super(key: key);

  final String trackId;

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  late final _futureTrack = context.read<ApiRepository>().getTrack(widget.trackId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Track>(
      future: _futureTrack,
      builder: (context, snap) {
        return AppListItem.fromTrack(
          snap.data,
          onTap: () {},
        );
      },
    );
  }
}
