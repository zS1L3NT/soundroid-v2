import 'package:flutter/material.dart';

class MainAppBar extends AppBar {
  MainAppBar({Key? key}) : super(key: key);

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: const Text('SounDroid'),
      actions: [
        PopupMenuButton(
          onSelected: (item) {},
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "settings",
              child: Row(
                children: [
                  Icon(Icons.settings, color: Colors.grey[800]),
                  const SizedBox(width: 8),
                  const Text("Settings"),
                ],
              ),
            )
          ],
        )
      ],
      elevation: 10,
    );
  }
}
