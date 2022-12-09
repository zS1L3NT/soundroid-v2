import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:soundroid/features/settings/settings.dart'
    show ChangePasswordSection, ConnectionsSection, ProfileSection;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Profile",
      children: const [
        ProfileSection(),
        ChangePasswordSection(),
        ConnectionsSection(),
      ],
    );
  }
}
