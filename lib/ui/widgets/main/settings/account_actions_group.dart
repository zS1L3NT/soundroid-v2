import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:soundroid/ui/widgets/app/icon.dart';

class AccountActionsGroup extends StatelessWidget {
  const AccountActionsGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
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
                title: const Text(
                  "Your music listening history will be cleared",
                ),
                content: const Text(
                  "Are you sure you want to clear your music listening history? SounDroid's song recommendations will not work as well after this.",
                  style: TextStyle(fontSize: 15),
                ),
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
                title: const Text(
                  "Your search history will be cleared",
                ),
                content: const Text(
                  "Are you sure you want to clear your music listening history?",
                  style: TextStyle(fontSize: 15),
                ),
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
                title: const Text(
                  "Your account data will be deleted",
                  style: TextStyle(color: Colors.red),
                ),
                content: const Text(
                  "Are you sure you want to delete all your account data? This action is irreversable!",
                  style: TextStyle(fontSize: 15),
                ),
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
                      Navigator.of(context).pushReplacementNamed("/auth");
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
                title: const Text("You will be logged out"),
                content: const Text(
                  'Are you sure you want to log out of SounDroid? Any music playing will be stopped.',
                  style: TextStyle(fontSize: 15),
                ),
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
                      Navigator.of(context).pushReplacementNamed("/auth");
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
    );
  }
}
