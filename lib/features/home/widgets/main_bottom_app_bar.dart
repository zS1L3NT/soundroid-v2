import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

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
