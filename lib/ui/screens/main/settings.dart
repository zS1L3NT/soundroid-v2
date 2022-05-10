import 'package:flutter/material.dart';
import 'package:soundroid/ui/widgets/main/settings/delete_data_card.dart';
import 'package:soundroid/ui/widgets/main/settings/profile_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: const [
          ProfileCard(),
          SizedBox(height: 8),
          DeleteDataCard(),
        ],
      ),
    );
  }
}
