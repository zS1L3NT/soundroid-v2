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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: FadeInImage.memoryNetwork(
                fadeInCurve: Curves.decelerate,
                placeholder: kTransparentImage,
                image: widget.playlist.thumbnail,
                fit: BoxFit.cover,
                width: 64,
                height: 64,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  widget.playlist.name,
                  width: MediaQuery.of(context).size.width - 112,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  "${widget.playlist.trackIds.length} tracks",
                  width: MediaQuery.of(context).size.width - 112,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
