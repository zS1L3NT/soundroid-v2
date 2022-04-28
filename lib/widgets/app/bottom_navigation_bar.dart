import 'package:flutter/material.dart';

class SounDroidBottomNavigationBar extends StatefulWidget {
  const SounDroidBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<SounDroidBottomNavigationBar> createState() =>
      _SounDroidBottomNavigationBarState();
}

class _SounDroidBottomNavigationBarState
    extends State<SounDroidBottomNavigationBar> {
  int _currentIndex = 0;
  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).primaryColor,
    );
  }
}
