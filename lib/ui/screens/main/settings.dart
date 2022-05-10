import 'package:flutter/material.dart';
import 'package:soundroid/ui/widgets/main/settings/account_actions_group.dart';
import 'package:soundroid/ui/widgets/main/settings/profile_group.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ProfileGroup(),
        AccountActionsGroup(),
      ],
    );
  }
}
