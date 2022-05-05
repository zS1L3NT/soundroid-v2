import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaylistItem extends StatefulWidget {
  final Playlist playlist;
  const PlaylistItem({Key? key, required this.playlist}) : super(key: key);

  @override
  State<PlaylistItem> createState() => _PlaylistItemState();
}

class _PlaylistItemState extends State<PlaylistItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: FadeInImage.memoryNetwork(
                fadeInCurve: Curves.decelerate,
                placeholder: kTransparentImage,
                image: widget.playlist.thumbnail,
                fit: BoxFit.cover,
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.marquee(
                  widget.playlist.name,
                  width: MediaQuery.of(context).size.width - 124,
                  extraHeight: 8,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                AppText.marquee(
                  "${widget.playlist.trackIds.length} tracks",
                  width: MediaQuery.of(context).size.width - 124,
                  extraHeight: 7,
                  fontSize: 12,
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
              iconSize: 20,
              splashRadius: 20,
            )
          ],
        ),
      ),
    );
  }
}
