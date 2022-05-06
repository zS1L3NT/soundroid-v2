import 'package:flutter/material.dart';
import 'package:soundroid/widgets/main/settings/delete_data_card.dart';
import 'package:soundroid/widgets/main/settings/profile_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
