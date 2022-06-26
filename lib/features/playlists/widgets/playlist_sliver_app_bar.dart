import 'dart:io';

import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/widgets.dart';

class PlaylistSliverAppBar extends SliverAppBar {
  const PlaylistSliverAppBar({
    Key? key,
    required this.initialPlaylist,
    required this.playlist,
    required this.controller,
  }) : super(key: key);

  final Playlist initialPlaylist;

  final Playlist? playlist;

  final ScrollController controller;

  @override
  State<PlaylistSliverAppBar> createState() => _PlaylistSliverAppBarState();
}

class _PlaylistSliverAppBarState extends State<PlaylistSliverAppBar> {
  late final _playlistId = widget.initialPlaylist.id;
  bool _isHeroComplete = false;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      final isCollapsed = widget.controller.offset > (200 + MediaQuery.of(context).padding.top);
      if (isCollapsed != _isCollapsed) {
        setState(() => _isCollapsed = isCollapsed);
      }
    });
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }

  void onReorderClick() async {
    Navigator.of(context).pop();

    final apiRepo = context.read<ApiRepository>();
    final trackIds = widget.playlist?.trackIds ?? [];
    final tracks = await Future.wait(trackIds.map(apiRepo.getTrack));

    Navigator.of(context).push(
      TracksReorderScreen.route(
        tracks: tracks,
        onFinish: (tracks) async {
          await context.read<PlaylistRepository>().updatePlaylist(
                (widget.playlist ?? widget.initialPlaylist)
                    .copyWith
                    .trackIds(tracks.map((track) => track.id).toList()),
              );
          AppSnackBar(
            text: "Updated playlist order",
            icon: Icons.check_rounded,
          ).show(context);
        },
      ),
    );
  }

  void updatePicture(ImageSource source) async {
    final newImage = await ImagePicker().pickImage(source: source);
    if (newImage == null) return;

    final croppedImage = await ImageCropper().cropImage(
      sourcePath: newImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage == null) return;

    Navigator.of(context).pop();
    final playlistRepo = context.read<PlaylistRepository>();
    await playlistRepo.setPicture(_playlistId, File(croppedImage.path));
    await playlistRepo.updatePlaylist(
      (widget.playlist ?? widget.initialPlaylist).copyWith.thumbnail(
            await playlistRepo.getPicture(_playlistId),
          ),
    );
    AppSnackBar(
      text: "Updated playlist image",
      icon: Icons.check_rounded,
    ).show(context);
  }

  void onRemovePictureClick() async {
    Navigator.of(context).pop();
    await context.read<PlaylistRepository>().updatePlaylist(
          (widget.playlist ?? widget.initialPlaylist).copyWith.thumbnail(null),
        );
    await context.read<PlaylistRepository>().deletePicture(_playlistId);
    AppSnackBar(
      text: "Removed playlist picture",
      icon: Icons.check_rounded,
    ).show(context);
  }

  void onChangePictureClick() {
    Navigator.of(context).pop();
    AppBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          ListTile(
            title: const Text("Choose from gallery"),
            leading: AppIcon.primaryColor(Icons.image_rounded),
            onTap: () => updatePicture(ImageSource.gallery),
          ),
          ListTile(
            title: const Text("Take a picture"),
            leading: AppIcon.primaryColor(Icons.photo_camera_rounded),
            onTap: () => updatePicture(ImageSource.camera),
          ),
          if (widget.playlist?.thumbnail != null)
            ListTile(
              title: const Text("Remove picture"),
              leading: AppIcon.primaryColor(Icons.delete_rounded),
              onTap: onRemovePictureClick,
            ),
          const SizedBox(height: 8),
        ],
      ),
    ).show(context);
  }

  void onRenameClick() {
    Navigator.of(context).pop();
    AppTextDialog(
      title: "Rename Playlist",
      textFieldName: "Playlist name",
      confirmText: "Rename",
      onConfirm: (String name) async {
        Navigator.of(context).pop();
        await context.read<PlaylistRepository>().updatePlaylist(
              (widget.playlist ?? widget.initialPlaylist).copyWith.name(name),
            );
        AppSnackBar(
          text: "Renamed playlist",
          icon: Icons.check_rounded,
        ).show(context);
      },
    ).show(context);
  }

  void onDeleteClick() {
    Navigator.of(context).pop();
    AppConfirmDialog(
      title: "Delete Playlist",
      description: "Are you sure you want to delete this playlist?",
      confirmText: "Delete",
      isDanger: true,
      onConfirm: () async {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        await context.read<PlaylistRepository>().deletePlaylist(_playlistId);
        AppSnackBar(
          text: "Deleted playlist",
          icon: Icons.check_rounded,
        ).show(context);
      },
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isCollapsed ? Text(widget.playlist?.name ?? "...") : const SizedBox(),
      ),
      expandedHeight: MediaQuery.of(context).size.width,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Builder(
            builder: (context) {
              final thumbnail =
                  _isHeroComplete ? widget.playlist?.thumbnail : widget.initialPlaylist.thumbnail;
              _isHeroComplete = true;

              final hero = Hero(
                tag: "playlist_$_playlistId",
                child: AppImage.network(
                  thumbnail,
                  errorIconPadding: 24,
                ),
              );
              if (thumbnail == null) {
                return hero;
              }
              return FittedBox(
                fit: BoxFit.cover,
                child: hero,
              );
            },
          ),
        ),
      ),
      leading: AppIcon(
        Icons.arrow_back_rounded,
        onPressed: onBackClick,
      ),
      actions: [
        AppIcon(
          Icons.more_vert_rounded,
          onPressed: () {
            AppBottomSheet(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text("Reorder songs"),
                    leading: AppIcon.primaryColor(Icons.swap_vert_rounded),
                    onTap: onReorderClick,
                  ),
                  ListTile(
                    title: const Text("Change picture"),
                    leading: AppIcon.primaryColor(Icons.camera_alt_rounded),
                    onTap: onChangePictureClick,
                  ),
                  ListTile(
                    title: const Text("Rename"),
                    leading: AppIcon.primaryColor(Icons.edit_rounded),
                    onTap: onRenameClick,
                  ),
                  ListTile(
                    title: const Text("Delete"),
                    leading: AppIcon.primaryColor(Icons.delete_rounded),
                    onTap: onDeleteClick,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ).show(context);
          },
        ),
      ],
    );
  }
}
