import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:listen_repository/listen_repository.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/features/settings/settings.dart';
import 'package:soundroid/widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void handleClearListeningHistory() async {
    final loader = AppLoader()..show(context);

    if (await context.read<ListenRepository>().deleteAll()) {
      const AppSnackBar(
        text: "Cleared listening history",
        icon: Icons.check_rounded,
      ).show(context);
    } else {
      const AppSnackBar(
        text: "Failed to clear listening history",
        icon: Icons.close_rounded,
        color: Colors.red,
      ).show(context);
    }

    Navigator.of(context).pop();
    loader.hide(context);
  }

  void handleClearSearchHistory() async {
    final loader = AppLoader()..show(context);

    if (await context.read<SearchRepository>().deleteAll()) {
      const AppSnackBar(
        text: "Cleared search history",
        icon: Icons.check_rounded,
      ).show(context);
    } else {
      const AppSnackBar(
        text: "Failed to clear search history",
        icon: Icons.close_rounded,
        color: Colors.red,
      ).show(context);
    }

    Navigator.of(context).pop();
    loader.hide(context);
  }

  void handleDeleteAccount() async {
    Navigator.of(context).pop();

    final loader = AppLoader()..show(context);
    final results = await Future.wait([
      context.read<ListenRepository>().deleteAll(),
      context.read<SearchRepository>().deleteAll(),
      context.read<PlaylistRepository>().deleteAll(),
      context.read<AuthenticationRepository>().deleteUser(),
    ]);

    if (results.every((result) => result)) {
      const AppSnackBar(
        text: "All account data deleted",
        icon: Icons.check_rounded,
      ).show(context);
    } else {
      const AppSnackBar(
        text: "Failed to delete all account data",
        icon: Icons.close_rounded,
        color: Colors.red,
      ).show(context);
    }

    loader.hide(context);
    Navigator.of(context).pushAndRemoveUntil(
      WelcomeScreen.route(),
      (route) => false,
    );
  }

  void handleLogout() async {
    if (await context.read<AuthenticationRepository>().logout()) {
      Navigator.of(context).pushReplacement(WelcomeScreen.route());
    } else {
      const AppSnackBar(
        text: "Failed to sign out",
        icon: Icons.close_rounded,
        color: Colors.red,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsGroup(
          title: "Profile",
          children: [
            const SizedBox(height: 8),
            SimpleSettingsTile(
              leading: AppImage.network(
                "https://wiki.d-addicts.com/images/4/4c/IU.jpg",
                borderRadius: BorderRadius.circular(20),
                size: 40,
              ),
              title: "Zechariah Tan",
              subtitle: "2100326D@student.tp.edu.sg",
              child: const ProfileScreen(),
            ),
          ],
        ),
        SettingsGroup(
          title: "Account Actions",
          children: [
            const SizedBox(height: 8),
            SimpleSettingsTile(
              leading: AppIcon.red(Icons.music_off_rounded),
              title: "Clear Listening History",
              subtitle: "Clear all of your music listening history",
              onTap: () {
                AppConfirmDialog(
                  title: "Clear Listening History?",
                  description: "Song recommendations will not work after this.",
                  confirmText: "Clear",
                  isDanger: true,
                  onConfirm: handleClearListeningHistory,
                ).show(context);
              },
            ),
            SimpleSettingsTile(
              leading: AppIcon.red(Icons.search_off_rounded),
              title: "Clear Search History",
              subtitle: "Clear all of your search history",
              onTap: () {
                AppConfirmDialog(
                  title: "Clear Search History?",
                  description: "You won't see anything in your search history after this.",
                  confirmText: "Clear",
                  isDanger: true,
                  onConfirm: handleClearSearchHistory,
                ).show(context);
              },
            ),
            SimpleSettingsTile(
              leading: AppIcon.red(Icons.delete_rounded),
              title: "Delete Account Data",
              subtitle:
                  "Deletes all of your data from SounDroid's servers, then logs you out of the App",
              onTap: () {
                AppConfirmDialog(
                  title: "Delete Account Data?",
                  description: "You will be logged out and your account will be deleted!",
                  confirmText: "Delete Data",
                  isDanger: true,
                  onConfirm: handleDeleteAccount,
                ).show(context);
              },
            ),
            SimpleSettingsTile(
              leading: const AppIcon(Icons.logout_rounded),
              title: "Logout",
              subtitle: "Logout of SounDroid",
              onTap: () {
                AppConfirmDialog(
                  title: "Logout",
                  description: "Any music playing will be stopped.",
                  confirmText: "Logout",
                  isDanger: true,
                  onConfirm: handleLogout,
                ).show(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
