import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlaylistPopupMenu {
  PlaylistPopupMenu({
    Key? key,
    required this.playlistId,
    required this.hasThumbnail,
  });

  final String playlistId;

  final bool hasThumbnail;

  void onReorderClick(BuildContext context) {}

  void onChangePictureClick(BuildContext context) {
    Future.delayed(Duration.zero, () {
      AppSelectDialog(
        title: "Change Picture",
        options: [
          AppSelectOption(
            title: "Choose from gallery",
            icon: Icons.image_rounded,
            onPressed: () {},
          ),
          AppSelectOption(
            title: "Take a picture",
            icon: Icons.photo_camera_rounded,
            onPressed: () {},
          ),
          if (!hasThumbnail)
            AppSelectOption(
              title: "Remove picture",
              icon: Icons.delete_rounded,
              onPressed: () {
                context.read<PlaylistRepository>().updatePlaylist(
                  playlistId,
                  {"thumbnail": null},
                );
                Navigator.of(context).pop();
              },
            ),
        ],
      ).show(context);
    });
  }

  void onRenameClick(BuildContext context) {
    Future.delayed(Duration.zero, () {
      AppTextDialog(
        title: "Rename Playlist",
        textFieldName: "Playlist name",
        confirmText: "Rename",
        onConfirm: (String name) {
          context.read<PlaylistRepository>().updatePlaylist(
            playlistId,
            {"name": name},
          );
          Navigator.of(context).pop();
        },
      ).show(context);
    });
  }

  void onDeletePlaylistClick(BuildContext context) {
    Future.delayed(Duration.zero, () {
      AppConfirmDialog(
        title: "Delete Playlist",
        description: "Are you sure you want to delete this playlist?",
        confirmText: "Delete",
        isDanger: true,
        onConfirm: () {
          context.read<PlaylistRepository>().deletePlaylist(playlistId);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ).show(context);
    });
  }

  List<PopupMenuEntry<dynamic>> itemBuilder(BuildContext context) {
    return [
      PopupMenuItem(
        child: Row(
          children: [
            AppIcon.black87(Icons.swap_vert_rounded),
            const SizedBox(width: 16),
            const Text("Reorder songs"),
          ],
        ),
        onTap: () => onReorderClick(context),
      ),
      PopupMenuItem(
        child: Row(
          children: [
            AppIcon.black87(Icons.camera_alt_rounded),
            const SizedBox(width: 16),
            const Text("Change picture"),
          ],
        ),
        onTap: () => onChangePictureClick(context),
      ),
      PopupMenuItem(
        child: Row(
          children: [
            AppIcon.black87(Icons.edit_rounded),
            const SizedBox(width: 16),
            const Text("Rename"),
          ],
        ),
        onTap: () => onRenameClick(context),
      ),
      PopupMenuItem(
        child: Row(
          children: [
            AppIcon.black87(Icons.delete_rounded),
            const SizedBox(width: 16),
            const Text("Delete"),
          ],
        ),
        onTap: () => onDeletePlaylistClick(context),
      ),
    ];
  }

  PopupMenuButton build() {
    return PopupMenuButton(
      itemBuilder: itemBuilder,
      child: IconButton(
        icon: AppIcon.white(Icons.more_vert_rounded),
        onPressed: null,
      ),
      offset: const Offset(0, 55),
    );
  }
}
