import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatefulWidget {
  final int index;
  final Function(int index) setIndex;
  const MainBottomNavigationBar({
    Key? key,
    required this.index,
    required this.setIndex,
  }) : super(key: key);

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
      onTap: widget.setIndex,
      currentIndex: widget.index,
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
