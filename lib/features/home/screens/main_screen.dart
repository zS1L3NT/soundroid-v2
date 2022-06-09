import 'package:flutter/material.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/features/settings/settings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const MainScreen(),
    );
  }

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

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: _appBars[_index],
      bottomNavigationBar: MainBottomAppBar(
        index: _index,
        setIndex: (index) => setState(() => _index = index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MainFloatingMusicButton(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_index],
      ),
    );
  }
}
