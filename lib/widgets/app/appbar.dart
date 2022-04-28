import 'package:flutter/material.dart';

class SounDroidAppBar extends AppBar {
  SounDroidAppBar({Key? key}) : super(key: key);

  @override
  State<SounDroidAppBar> createState() => _SounDroidAppBarState();
}

class _SounDroidAppBarState extends State<SounDroidAppBar> {
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
