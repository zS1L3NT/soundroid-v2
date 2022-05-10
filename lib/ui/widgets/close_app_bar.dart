import 'package:flutter/material.dart';

class CloseAppBar extends AppBar {
  CloseAppBar({Key? key}) : super(key: key);

  @override
  State<CloseAppBar> createState() => _CloseAppBarState();
}

class _CloseAppBarState extends State<CloseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.close),
        color: Colors.black,
        splashRadius: 20,
      ),
    );
  }
}
