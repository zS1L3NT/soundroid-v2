import 'package:flutter/material.dart';
import 'package:soundroid/screens/main/home_screen.dart';
import 'package:soundroid/screens/main/library_screen.dart';
import 'package:soundroid/screens/main/profile_screen.dart';
import 'package:soundroid/screens/main/search_screen.dart';
import 'package:soundroid/widgets/main/appbar.dart';
import 'package:soundroid/widgets/main/bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _screenIndex = 0;
  final _screens = const <Widget>[
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: MainBottomNavigationBar(
        index: _screenIndex,
        setIndex: (index) {
          setState(() {
            switch (index) {
              case 0:
                _screenIndex = 0;
                break;
              case 1:
                _screenIndex = 1;
                break;
              case 2:
                _screenIndex = 2;
                break;
              case 3:
                _screenIndex = 3;
                break;
            }
            _screenIndex = index;
          });
        },
      ),
      body: _screens[_screenIndex],
    );
  }
}
