import 'package:flutter/material.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("SounDroid"),
      elevation: 10,
    );
  }
}
