import 'package:api_repository/api_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/utils/utils.dart';
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
    this.topRightIcon,
    this.favourite,
    this.downloadProgress,
    this.isDraggable = false,
    this.dragIndex,
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

  /// Icon that are shown around the image of a list tile, if any
  ///
  /// If these properties are set a white border and an Icon will render
  /// around the [image]
  final IconData? topRightIcon;

  final bool? favourite;

  final double? downloadProgress;

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
    IconData? topRightIcon,
    required Function() onTap,
    Function()? onMoreTap,
    bool isDraggable = false,
    int? dragIndex,
  }) {
    if (isDraggable) {
      assert(onMoreTap == null, "Cannot define a more tap handler when isDraggable is true");
      assert(dragIndex != null, "Must define a dragIndex when a Track isDraggable");
    }

    return Builder(
      key: key,
      builder: (context) {
        return StreamBuilder<Track?>(
          stream: context.read<MusicProvider>().current,
          builder: (context, snap) {
            final current = snap.data;

            return StreamBuilder<User?>(
              stream: context.read<AuthenticationRepository>().currentUser,
              builder: (context, snap) {
                final user = snap.data;
                final downloadManager = context.watch<DownloadManager>();

                return StreamBuilder<bool>(
                  stream: isOnlineStream(context.read<ApiRepository>()),
                  builder: (context, snap) {
                    final isOnline = snap.data == true;

                    return AppListItem(
                      title: track?.title ?? "...",
                      subtitle: track?.artists.map((artist) => artist.name).join(", ") ?? "...",
                      image: AppImage.network(
                        track?.thumbnail,
                        borderRadius: BorderRadius.circular(8),
                        size: 56,
                      ),
                      topRightIcon: topRightIcon,
                      favourite: user?.likedTrackIds.contains(track?.id),
                      downloadProgress: downloadManager.downloaded.contains(track?.id)
                          ? 1
                          : downloadManager.queue == null
                              ? null
                              : downloadManager.queue!.contains(track?.id)
                                  ? downloadManager.queue!.first == track!.id
                                      ? downloadManager.downloadProgress ?? 0
                                      : 0
                                  : 0,
                      onTap: onTap,
                      onMoreTap: onMoreTap,
                      isActive: track == current,
                      isDisabled: !(downloadManager.downloaded.contains(track?.id) || isOnline),
                      isDraggable: isDraggable,
                      dragIndex: dragIndex,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  /// Adapter for rendering [Album] items.
  factory AppListItem.fromAlbum(
    Album album, {
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
      topRightIcon: Icons.album_rounded,
      onTap: onTap,
      onMoreTap: onMoreTap,
      isActive: false,
    );
  }

  /// Adapter for rendering [Playlist] items.
  static Widget fromPlaylist(
    Playlist playlist, {
    IconData? topRightIcon,
    required Function() onTap,
    Function()? onMoreTap,
    bool isDisabled = false,
    required String heroTag,
  }) {
    return Builder(
      builder: (context) {
        final downloaded = context.select<DownloadManager, int>(
          (manager) => playlist.trackIds.where(manager.downloaded.contains).length,
        );

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
          topRightIcon: topRightIcon,
          favourite: playlist.favourite,
          downloadProgress: playlist.download ? downloaded / playlist.trackIds.length : null,
          onTap: onTap,
          onMoreTap: onMoreTap,
          isActive: false,
          isDisabled: isDisabled,
        );
      },
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

            // A circular background for the topRightIcon, if any
            Positioned(
              top: -5,
              right: -5,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: topRightIcon != null ? 23 : 0,
                height: topRightIcon != null ? 23 : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
            ),

            // The topRightIcon, if any
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: topRightIcon != null
                    ? Icon(
                        topRightIcon,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      )
                    : const SizedBox(),
              ),
            ),

            // A circular background for the favourite icon
            Positioned(
              bottom: -5,
              left: -5,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: favourite == true ? 23 : 0,
                height: favourite == true ? 23 : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
            ),

            // The favourite icon
            Positioned(
              bottom: 0,
              left: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: favourite == true
                    ? Icon(
                        Icons.favorite_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      )
                    : const SizedBox(),
              ),
            ),

            // A circular background for the download progress
            Positioned(
              bottom: -5,
              right: -5,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: downloadProgress != null ? 23 : 0,
                height: downloadProgress != null ? 23 : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
            ),

            // The download progress
            Positioned(
              bottom: 0,
              right: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: downloadProgress != null
                    ? downloadProgress == 1
                        ? AppIcon.primaryColor(
                            Icons.download_done_rounded,
                            size: 14,
                          )
                        : downloadProgress == 0
                            ? const AppIcon(
                                Icons.download_rounded,
                                size: 14,
                              )
                            : Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.all(1),
                                child: CircularProgressIndicator(
                                  value: downloadProgress,
                                  strokeWidth: 2,
                                ),
                              )
                    : const SizedBox(),
              ),
            ),
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
