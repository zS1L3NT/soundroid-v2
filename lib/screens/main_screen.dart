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
  var _screenIndex = 1;
  var _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final _screens = <Widget>[
      const HomeScreen(),
      SearchScreen(query: _searchQuery),
      const LibraryScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: MainAppBar(
          screenIndex: _screenIndex,
          setSearchQuery: (searchQuery) {
            setState(() {
              _searchQuery = searchQuery;
            });
          }),
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
