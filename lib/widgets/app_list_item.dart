import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
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
    this.isDraggable = false,
    this.dragIndex,
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

  final bool isDraggable;

  final int? dragIndex;

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
  ///
  /// The widget also listens to the current playing track from the
  /// [MusicProvider] and sets the active state based on if the current
  /// track playing is this track.
  ///
  /// If [isDraggable] is true, the leading icon in the list tile will be
  /// a drag handle.
  /// Else If [onMoreTap] is true, the trailing icon in the list tile will be
  /// a more button.
  /// Else there will be no trailing button
  static Widget fromTrack(
    Track? track, {
    Key? key,
    IconData? icon,
    bool isDownloaded = false,
    required Function() onTap,
    Function()? onMoreTap,
    bool isDraggable = false,
    int? dragIndex,
  }) {
    if (isDraggable) {
      assert(onMoreTap == null, "Cannot define a more tap handler when isDraggable is true");
      assert(dragIndex != null, "Must define a dragIndex when a Track isDraggable");
    }

    if (isDownloaded) {
      assert(icon == null, "Cannot define an icon when isDownloaded is true");
    }

    return Builder(
      key: key,
      builder: (context) {
        return StreamBuilder<Track?>(
          stream: context.read<MusicProvider>().current,
          builder: (context, snap) {
            return AppListItem(
              title: track?.title ?? "...",
              subtitle: track?.artists.map((artist) => artist.name).join(", ") ?? "...",
              image: AppImage.network(
                track?.thumbnail,
                borderRadius: BorderRadius.circular(8),
                size: 56,
              ),
              icon: isDownloaded ? Icons.download_rounded : icon,
              onTap: onTap,
              onMoreTap: onMoreTap,
              isActive: track == snap.data,
              isDraggable: isDraggable,
              dragIndex: dragIndex,
            );
          },
        );
      },
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
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: AppText.ellipse(
          subtitle,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: isActive ? Theme.of(context).primaryColor : null,
              ),
        ),
        trailing: isDraggable
            ? ReorderableDragStartListener(
                index: dragIndex!,
                child: AppIcon.black87(
                  Icons.drag_handle_rounded,
                  onPressed: () {},
                ),
              )
            : onMoreTap != null
                ? AppIcon.black87(
                    Icons.more_vert_rounded,
                    onPressed: onMoreTap,
                  )
                : null,
        contentPadding: EdgeInsets.only(
          left: 16,
          right: (onMoreTap != null || isDraggable) ? 0 : 16,
        ),
      ),
    );
  }
}
