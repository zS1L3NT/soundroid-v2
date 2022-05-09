import 'package:flutter/material.dart';
import 'package:soundroid/screens/main/home.dart';
import 'package:soundroid/screens/main/library.dart';
import 'package:soundroid/screens/main/settings.dart';
import 'package:soundroid/screens/main/search.dart';
import 'package:soundroid/widgets/main/bottom_app_bar.dart';
import 'package:soundroid/widgets/main/home/app_bar.dart';
import 'package:soundroid/widgets/main/library/app_bar.dart';
import 'package:soundroid/widgets/main/settings/app_bar.dart';
import 'package:soundroid/widgets/main/search/app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _screens = const [
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    SettingsScreen(),
  ];

  final _appBars = [
    HomeAppBar(),
    SearchAppBar(),
    LibraryAppBar(),
    SettingsAppBar(),
  ];

  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _appBars[_index],
      bottomNavigationBar: MainBottomAppBar(
        index: _index,
        setIndex: (index) => setState(() => _index = index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: _screens[_index],
    );
  }
}
