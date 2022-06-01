import 'package:flutter/material.dart';
import 'package:soundroid/ui/widgets/app/icon.dart';

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
      leading: AppIcon.black87(
        Icons.close_rounded,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
