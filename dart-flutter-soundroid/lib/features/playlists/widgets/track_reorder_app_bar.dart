import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class TrackReorderAppBar extends AppBar {
  TrackReorderAppBar({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  final Function() onFinish;

  @override
  State<TrackReorderAppBar> createState() => _TrackReorderAppBarState();
}

class _TrackReorderAppBarState extends State<TrackReorderAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Reorder tracks"),
      leading: AppIcon(
        Icons.close_rounded,
        onPressed: Navigator.of(context).pop,
      ),
      actions: [
        AppIcon.white(
          Icons.check_rounded,
          onPressed: () {
            Navigator.of(context).pop();
            widget.onFinish();
          },
        ),
      ],
    );
  }
}
