import 'dart:math';

import 'package:flutter/material.dart';
import 'package:soundroid/features/home/screens/home_screen.dart';
import 'package:soundroid/features/playlists/screens/library_screen.dart';
import 'package:soundroid/features/search/screens/search_screen.dart';
import 'package:soundroid/screens/music/playing_screen.dart';
import 'package:soundroid/screens/settings_screen.dart';
import 'package:soundroid/utils/route_transition.dart';
import 'package:soundroid/widgets/app_widgets.dart';

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

class MainBottomAppBar extends StatelessWidget {
  const MainBottomAppBar({
    Key? key,
    required this.index,
    required this.setIndex,
  }) : super(key: key);

  final int index;

  final Function(int) setIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppIcon(
              Icons.home_rounded,
              color: index == 0 ? Theme.of(context).primaryColor : null,
              onPressed: () {
                setIndex(0);
              },
            ),
            AppIcon(
              Icons.search_rounded,
              color: index == 1 ? Theme.of(context).primaryColor : null,
              onPressed: () {
                setIndex(1);
              },
            ),
            const SizedBox(
              width: 48,
            ),
            AppIcon(
              Icons.library_music_rounded,
              color: index == 2 ? Theme.of(context).primaryColor : null,
              onPressed: () {
                setIndex(2);
              },
            ),
            AppIcon(
              Icons.settings_rounded,
              color: index == 3 ? Theme.of(context).primaryColor : null,
              onPressed: () {
                setIndex(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainFloatingMusicButton extends StatefulWidget {
  const MainFloatingMusicButton({Key? key}) : super(key: key);

  @override
  State<MainFloatingMusicButton> createState() => _MainFloatingMusicButtonState();
}

class _MainFloatingMusicButtonState extends State<MainFloatingMusicButton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 15),
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) => Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: child,
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: AppImage.network(
                "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
          const SizedBox(
            width: 64,
            height: 64,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              value: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.5),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: const Color.fromRGBO(0, 0, 0, 0.4),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                onTap: () {
                  final size = MediaQuery.of(context).size;
                  Navigator.of(context).push(
                    RouteTransition.reveal(
                      const PlayingScreen(),
                      center: Offset(size.width / 2, size.height),
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
