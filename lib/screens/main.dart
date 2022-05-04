import 'package:flutter/material.dart';
import 'package:soundroid/screens/main/home.dart';
import 'package:soundroid/screens/main/library.dart';
import 'package:soundroid/screens/main/profile.dart';
import 'package:soundroid/screens/main/search.dart';
import 'package:soundroid/widgets/main/appbar.dart';
import 'package:soundroid/widgets/main/bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _screenIndex = 1;

  @override
  Widget build(BuildContext context) {
    const _screens = [
      HomeScreen(),
      SearchScreen(),
      LibraryScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: MainAppBar(screenIndex: _screenIndex),
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
