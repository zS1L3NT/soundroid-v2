import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class AppListItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final Function() onTap;
  const AppListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  static AppListItem fromTrack(
    Track track, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: track.title,
      subtitle: track.artists,
      image: track.thumbnail,
      onTap: onTap,
    );
  }

  static AppListItem fromPlaylist(
    Playlist playlist, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: playlist.name,
      subtitle: "${playlist.trackIds.length} tracks",
      image: playlist.thumbnail,
      onTap: onTap,
    );
  }

  static AppListItem fromSearchResult(
    Map<String, String> result, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: result["title"]!,
      subtitle: result["artists"]!,
      image: result["thumbnail"]!,
      onTap: onTap,
    );
  }

  @override
  State<AppListItem> createState() => _AppListItemState();
}

class _AppListItemState extends State<AppListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: FadeInImage.memoryNetwork(
              fadeInCurve: Curves.decelerate,
              placeholder: kTransparentImage,
              image: widget.image,
              fit: BoxFit.cover,
              width: 48,
              height: 48,
            ),
          ),
          title: AppText.ellipse(
            widget.title,
            extraHeight: 9,
            width: MediaQuery.of(context).size.width,
          ),
          subtitle: AppText.ellipse(
            widget.subtitle,
            fontSize: 14,
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
          contentPadding: const EdgeInsets.only(left: 16, right: 8),
        ),
      ),
    );
  }
}
