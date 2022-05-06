import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    Key? key,
    required this.index,
    required this.setIndex,
  }) : super(key: key);

  final int index;

  final Function(int index) setIndex;

  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
      onTap: setIndex,
      currentIndex: index,
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
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).primaryColor,
    );
  }
}
