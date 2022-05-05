import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class TrackItem extends StatefulWidget {
  final Track track;
  const TrackItem({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: FadeInImage.memoryNetwork(
            fadeInCurve: Curves.decelerate,
            placeholder: kTransparentImage,
            image: widget.track.thumbnail,
            fit: BoxFit.cover,
            width: 48,
            height: 48,
          ),
        ),
        title: AppText(
          widget.track.title,
          type: TextType.ellipse,
          fontSize: 18,
          extraHeight: 9,
          width: MediaQuery.of(context).size.width,
        ),
        subtitle: AppText(
          widget.track.artists,
          type: TextType.ellipse,
          extraHeight: 11,
          fontWeight: FontWeight.w400,
          width: MediaQuery.of(context).size.width,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          splashRadius: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}
