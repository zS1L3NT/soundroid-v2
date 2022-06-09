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
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text("Clear Listening History?"),
                    content: const Text("Song recommendations will not work after this."),
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Clear"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SimpleSettingsTile(
              leading: AppIcon.red(Icons.search_off_rounded),
              title: "Clear Search History",
              subtitle: "Clear all of your search history",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text("Clear Search History?"),
                    content:
                        const Text("You won't see anything in your search history after this."),
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Clear"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SimpleSettingsTile(
              leading: AppIcon.red(Icons.delete_rounded),
              title: "Delete Account Data",
              subtitle:
                  "Deletes all of your data from SounDroid's servers, then logs you out of the App",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text("Delete Account Data?"),
                    content: const Text("You will be logged out and your account will be deleted!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(WelcomeScreen.route());
                        },
                        child: const Text("Delete Data"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SimpleSettingsTile(
              leading: const AppIcon(Icons.logout_rounded),
              title: "Logout",
              subtitle: "Logout of SounDroid",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text('Any music playing will be stopped.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(WelcomeScreen.route());
                        },
                        child: const Text("Logout"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
