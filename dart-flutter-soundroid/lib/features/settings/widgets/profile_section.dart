import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/widgets/widgets.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;
  dynamic _picture;

  @override
  void initState() {
    super.initState();

    context.read<AuthenticationRepository>().currentUserRef.get().then((doc) {
      setState(() {
        final user = doc.data()!;
        _picture = user.picture != null ? File(user.picture!) : null;
        _nameController.text = user.name;
      });
    });
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
    setState(() => _picture = croppedImage);
  }

  void handleRemovePicture() async {
    Navigator.of(context).pop();
    setState(() => _picture = null);
  }

  void handleChangePicture() {
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
          StreamBuilder<User?>(
            stream: context.read<AuthenticationRepository>().currentUser,
            builder: (context, snap) {
              return _picture != null
                  ? ListTile(
                      title: const Text("Remove picture"),
                      leading: AppIcon.primaryColor(Icons.delete_rounded),
                      onTap: handleRemovePicture,
                    )
                  : const SizedBox();
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    ).show(context);
  }

  void handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final authenticationRepo = context.read<AuthenticationRepository>();
    try {
      // Updating profile picture
      if (_picture is! File) {
        if (_picture is CroppedFile) {
          await authenticationRepo.setPicture(File(_picture.path));
        } else {
          await authenticationRepo.deletePicture();
        }
      }

      // Updating username
      final user = (await authenticationRepo.currentUserRef.get()).data()!;
      if (!(await authenticationRepo.updateUser(user.copyWith(name: _nameController.text)))) {
        throw Error();
      }

      AppSnackBar.success("Updated profile").show(context);
    } catch (e) {
      debugPrint("ERROR Update Profile Failed: $e");
      AppSnackBar.error((e as dynamic).message).show(context);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SettingsGroup(
        title: "Update Details",
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _picture is CroppedFile
                      ? AppImage.file(
                          File(_picture.path),
                          borderRadius: BorderRadius.circular(32),
                          size: 64,
                        )
                      : AppImage.network(
                          _picture?.path,
                          borderRadius: BorderRadius.circular(32),
                          size: 64,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : handleChangePicture,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppIcon(Icons.upload_rounded),
                        Text("Change Image"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'What should we call you?',
                labelText: 'Display Name',
                prefixIcon: AppIcon(Icons.person_rounded),
                contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 4),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: _isLoading ? null : handleSave,
              child: _isLoading
                  ? AppIcon.loading(
                      size: 12,
                      padding: 0,
                      color: Colors.white,
                    )
                  : const Text("Save Details"),
            ),
          ),
        ],
      ),
    );
  }
}
