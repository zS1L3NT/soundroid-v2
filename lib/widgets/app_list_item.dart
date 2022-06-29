import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:soundroid/widgets/widgets.dart';

/// A helper class for building ListItems. This widget supports building
/// - Track list items
/// - Album list items
/// - Playlist list items
///
/// This widget uses [ListTile] to show the list item.
///
/// ### Rationale
/// - I want all my [Track], [Album] and [Playlist] list items to look similar everywhere
/// - I want to abstract away the code for building the list items since it is quite lengthy
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
    this.isDisabled = false,
  }) : super(key: key);

  /// The title of the list tile
  final String title;

  /// The title of the list tile
  final String subtitle;

  /// The image shown in the list tile
  final Widget image;

  /// The icon shown at the bottom right of a list tile, if any
  ///
  /// If this property is set a white border and an Icon will render
  /// at the bottom right of the [image]
  final IconData? icon;

  /// The function that is called when the list tile is tapped
  final Function() onTap;

  /// The function that is called when the more button is tapped, if any
  ///
  /// If this property is set, a trailing menu Icon will render and
  /// this function will be called when the Icon is tapped.
  final Function()? onMoreTap;

  /// Whether the list tile should make this item stand out to other list tiles
  ///
  /// Highlights the [title] and [subtitle] in with
  /// the primary color and bolds the text
  final bool isActive;

  /// Whether the list tile should be disabled
  ///
  /// Does not attach the [onTap] or [onMoreTap] callbacks and
  /// reduces the opacity of the list tile
  final bool isDisabled;

  /// Adapter for rendering [Track] items.
  ///
  /// The [track] is allowed to be null and will render ellipsis if so.
  ///
  /// The image rendered will be [AppImage.network] so as to
  /// show a shimmer if the track is null
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
        borderRadius: BorderRadius.circular(8),
        size: 56,
      ),
      icon: icon,
      onTap: onTap,
      onMoreTap: onMoreTap,
      isActive: isActive,
    );
  }

  /// Adapter for rendering [Album] items.
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
          borderRadius: BorderRadius.circular(8),
          size: 56,
        ),
      ),
      icon: icon,
      onTap: onTap,
      onMoreTap: onMoreTap,
      isActive: false,
    );
  }

  /// Adapter for rendering [Playlist] items.
  factory AppListItem.fromPlaylist(
    Playlist playlist, {
    IconData? icon,
    required Function() onTap,
    Function()? onMoreTap,
    bool isDisabled = false,
    required String heroTag,
  }) {
    return AppListItem(
      title: playlist.name,
      subtitle: "${playlist.trackIds.length} tracks",
      image: Hero(
        tag: heroTag,
        child: FittedBox(
          fit: BoxFit.cover,
          child: AppImage.network(
            playlist.thumbnail,
            borderRadius: BorderRadius.circular(8),
            size: 56,
          ),
        ),
      ),
      icon: icon,
      onTap: onTap,
      onMoreTap: onMoreTap,
      isActive: false,
      isDisabled: isDisabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.4 : 1,
      child: ListTile(
        onTap: onTap,
        enabled: !isDisabled,
        leading: Stack(
          children: [
            // The image provided
            image,

            // A border for the icon, if any
            Positioned(
              right: -5,
              bottom: -5,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: icon != null ? 25 : 0,
                height: icon != null ? 25 : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            // The icon, if any
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
