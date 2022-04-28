import 'package:flutter/material.dart';
import 'package:soundroid/widgets/app/appbar.dart';
import 'package:soundroid/widgets/app/bottom_navigation_bar.dart';

class SounDroidScaffold extends StatefulWidget {
  const SounDroidScaffold({Key? key}) : super(key: key);

  @override
  State<SounDroidScaffold> createState() => SounDroidScaffoldState();
}

class SounDroidScaffoldState extends State<SounDroidScaffold> {
  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: SounDroidAppBar(),
      bottomNavigationBar: const SounDroidBottomNavigationBar(),
    );
  }
}
