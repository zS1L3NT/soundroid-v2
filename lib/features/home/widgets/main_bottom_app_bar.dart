import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class MainBottomAppBar extends StatelessWidget {
  const MainBottomAppBar({
    Key? key,
    required this.page,
    required this.setPage,
  }) : super(key: key);

  final int page;

  final Function(int) setPage;

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
              color: page == 0 ? Theme.of(context).primaryColor : null,
              onPressed: () => setPage(0),
            ),
            AppIcon(
              Icons.search_rounded,
              color: page == 1 ? Theme.of(context).primaryColor : null,
              onPressed: () => setPage(1),
            ),
            const SizedBox(
              width: 48,
            ),
            AppIcon(
              Icons.library_music_rounded,
              color: page == 2 ? Theme.of(context).primaryColor : null,
              onPressed: () => setPage(2),
            ),
            AppIcon(
              Icons.settings_rounded,
              color: page == 3 ? Theme.of(context).primaryColor : null,
              onPressed: () => setPage(3),
            ),
          ],
        ),
      ),
    );
  }
}
