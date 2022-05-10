import 'package:flutter/material.dart';

class LibraryAppBar extends AppBar {
  LibraryAppBar({Key? key}) : super(key: key);

  @override
  State<LibraryAppBar> createState() => _LibraryAppBarState();
}

class _LibraryAppBarState extends State<LibraryAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Library"),
      elevation: 10,
    );
  }
}
