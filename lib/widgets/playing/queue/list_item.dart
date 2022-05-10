import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class QueueListItem extends StatefulWidget {
  const QueueListItem({
    Key? key,
    required this.index,
    required this.track,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  final int index;

  final Track track;

  final Function() onTap;

  final Function() onLongPress;

  @override
  State<QueueListItem> createState() => _QueueListItemState();
}

class _QueueListItemState extends State<QueueListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: FadeInImage.memoryNetwork(
            fadeInCurve: Curves.decelerate,
            placeholder: kTransparentImage,
            image: widget.track.thumbnail,
            fit: BoxFit.cover,
            width: 56,
            height: 56,
          ),
        ),
        title: AppText.ellipse(
          widget.track.title,
          width: MediaQuery.of(context).size.width,
        ),
        subtitle: AppText.ellipse(
          widget.track.artists,
          width: MediaQuery.of(context).size.width,
        ),
        trailing: ReorderableDragStartListener(
          index: widget.index,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.drag_handle),
            splashRadius: 20,
            color: Colors.black,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 16, right: 4),
      ),
    );
  }
}
