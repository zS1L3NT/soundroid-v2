import 'package:flutter/material.dart';

class SettingsAppBar extends AppBar {
  SettingsAppBar({Key? key}) : super(key: key);

  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();
}

class _SettingsAppBarState extends State<SettingsAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Settings"),
    );
  }
}
