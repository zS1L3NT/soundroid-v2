import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
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
    // Animate the floating action button coming into the navigation bar
    // The values in the animated containers took me 2 hours of trail and error to figure out
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: StreamBuilder<Track?>(
            stream: context.read<MusicProvider>().current,
            builder: (context, snap) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(),
                  AppIcon(
                    Icons.home_rounded,
                    color: page == 0 ? Theme.of(context).primaryColor : null,
                    onPressed: () => setPage(0),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: snap.hasData ? 10 : 16,
                  ),
                  AppIcon(
                    Icons.search_rounded,
                    color: page == 1 ? Theme.of(context).primaryColor : null,
                    onPressed: () => setPage(1),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: snap.hasData ? 88 : 16,
                  ),
                  AppIcon(
                    Icons.library_music_rounded,
                    color: page == 2 ? Theme.of(context).primaryColor : null,
                    onPressed: () => setPage(2),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: snap.hasData ? 10 : 16,
                  ),
                  AppIcon(
                    Icons.settings_rounded,
                    color: page == 3 ? Theme.of(context).primaryColor : null,
                    onPressed: () => setPage(3),
                  ),
                  const SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
