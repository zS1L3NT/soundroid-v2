import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:soundroid/widgets/widgets.dart';

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
  factory AppListItem.fromAlbum(
    Album album, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: album.title,
      subtitle: album.artists.map((artist) => artist.name).join(", "),
      image: AppImage.network(
        album.thumbnail,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        size: 56,
      ),
      onTap: onTap,
    );
  }

  factory AppListItem.fromPlaylist(
    Playlist playlist, {
    required Function() onTap,
  }) {
    return AppListItem(
      title: playlist.name,
      subtitle: "${playlist.trackIds.length} tracks",
      image: Hero(
        tag: "playlist_${playlist.id}",
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
