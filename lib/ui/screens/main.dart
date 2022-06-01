import 'dart:math';

import 'package:flutter/material.dart';
import 'package:soundroid/ui/screens/main/home.dart';
import 'package:soundroid/ui/screens/main/library.dart';
import 'package:soundroid/ui/screens/main/settings.dart';
import 'package:soundroid/ui/screens/main/search.dart';
import 'package:soundroid/ui/screens/playing.dart';
import 'package:soundroid/ui/widgets/app/icon.dart';
import 'package:soundroid/utils/route_transition.dart';

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
      body: _screens[_index],
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
    Color getColor(int index) {
      return this.index == index ? Theme.of(context).primaryColor : Colors.grey;
    }

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setIndex(0);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon(
                      Icons.home_rounded,
                      color: getColor(0),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColor(0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setIndex(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon(
                      Icons.search_rounded,
                      color: getColor(1),
                    ),
                    Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColor(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setIndex(2);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon(
                      Icons.library_music_rounded,
                      color: getColor(2),
                    ),
                    Text(
                      "Library",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColor(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setIndex(3);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon(
                      Icons.settings_rounded,
                      color: getColor(3),
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColor(3),
                      ),
                    ),
                  ],
                ),
              ),
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
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
                ),
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
