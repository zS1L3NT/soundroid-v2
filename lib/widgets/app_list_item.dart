import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/models/search_result.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/app_widgets.dart';

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

  final Widget image;

  final Function() onTap;

  factory AppListItem.fromTrack(
    Track? track, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: track?.title ?? "...",
      subtitle: track?.artists.map((artist) => artist.name).join(", ") ?? "...",
      image: AppImage.network(
        track?.thumbnail,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        size: 56,
      ),
      onTap: onTap,
    );
  }

  factory AppListItem.fromPlaylist(
    String playlistId,
    Playlist playlist, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: playlist.name,
      subtitle: "${playlist.trackIds.length} tracks",
      image: Hero(
        tag: "playlist_$playlistId",
        child: FittedBox(
          fit: BoxFit.cover,
          child: AppImage.network(
            playlist.thumbnail,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            size: 56,
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  factory AppListItem.fromSearchResult(
    SearchResult result, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: result.title,
      subtitle: result.artists.map((artist) => artist.name).join(", "),
      image: AppImage.network(
        result.thumbnail,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        size: 56,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: image,
        title: AppText.ellipse(title),
        subtitle: AppText.ellipse(subtitle),
        trailing: AppIcon.black87(
          Icons.more_vert_rounded,
          onPressed: () {},
        ),
        contentPadding: const EdgeInsets.only(left: 16),
      ),
    );
  }
}
