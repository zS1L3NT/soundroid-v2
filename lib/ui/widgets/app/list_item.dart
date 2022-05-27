import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/models/search_result.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/ui/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class AppListItem extends StatelessWidget {
  const AppListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  final String title;

  final String subtitle;

  final String image;

  final Function() onTap;

  static AppListItem fromTrack(
    Track track, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: track.title,
      subtitle: track.artistIds.join(", "),
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
    SearchResult result, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: result.title,
      subtitle: result.artistIds.join(", "),
      image: result.thumbnail,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: FadeInImage.memoryNetwork(
            fadeInCurve: Curves.decelerate,
            placeholder: kTransparentImage,
            image: image,
            fit: BoxFit.cover,
            width: 56,
            height: 56,
          ),
        ),
        title: AppText.ellipse(title),
        subtitle: AppText.ellipse(subtitle),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
          splashRadius: 20,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.only(left: 16),
      ),
    );
  }
}
