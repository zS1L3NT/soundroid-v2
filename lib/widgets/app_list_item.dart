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
    this.icon,
    required this.onTap,
    this.onMoreTap,
    required this.isActive,
  }) : super(key: key);

  final String title;

  final String subtitle;

  final Widget image;

  final IconData? icon;

  final Function() onTap;

  final Function()? onMoreTap;

  final bool isActive;

  factory AppListItem.fromTrack(
    Track? track, {
    IconData? icon,
    required Function() onTap,
    Function()? onMoreTap,
    required bool isActive,
  }) {
    return AppListItem(
      title: track?.title ?? "...",
      subtitle: track?.artists.map((artist) => artist.name).join(", ") ?? "...",
      image: AppImage.network(
        track?.thumbnail,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        size: 56,
      ),
      icon: icon,
      onTap: onTap,
      onMoreTap: onMoreTap,
      isActive: isActive,
    );
  }

  factory AppListItem.fromAlbum(
    Album album, {
    IconData? icon,
    required Function() onTap,
    Function()? onMoreTap,
  }) {
    return AppListItem(
      title: album.title,
      subtitle: album.artists.map((artist) => artist.name).join(", "),
      image: Hero(
        tag: "album_${album.id}",
        child: AppImage.network(
          album.thumbnail,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          size: 56,
        ),
      ),
      icon: icon,
      onTap: onTap,
      onMoreTap: onMoreTap,
      isActive: false,
    );
  }

  factory AppListItem.fromPlaylist(
    Playlist playlist, {
    IconData? icon,
    required Function() onTap,
    Function()? onMoreTap,
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
      icon: icon,
      onTap: onTap,
      onMoreTap: onMoreTap,
      isActive: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Stack(
          children: [
            image,
            Positioned(
              right: -5,
              bottom: -5,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: icon != null ? 25 : 0,
                height: icon != null ? 25 : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: icon != null
                    ? Icon(
                        icon,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      )
                    : const SizedBox(),
              ),
            )
          ],
        ),
        title: AppText.ellipse(
          title,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: isActive ? Theme.of(context).primaryColor : null,
                fontWeight: isActive ? FontWeight.w600 : null,
              ),
        ),
        subtitle: AppText.ellipse(
          subtitle,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: isActive ? Theme.of(context).primaryColor : null,
                fontWeight: isActive ? FontWeight.w600 : null,
              ),
        ),
        trailing: onMoreTap != null
            ? AppIcon.black87(
                Icons.more_vert_rounded,
                onPressed: onMoreTap,
              )
            : null,
        contentPadding: EdgeInsets.only(
          left: 16,
          right: onMoreTap != null ? 0 : 16,
        ),
      ),
    );
  }
}
