import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/features/settings/settings.dart';
import 'package:soundroid/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                  onConfirm: () {},
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
                  onConfirm: () {},
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
                  onConfirm: () {},
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
                  onConfirm: () {
                    Navigator.of(context).pushReplacement(WelcomeScreen.route());
                  },
                ).show(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
