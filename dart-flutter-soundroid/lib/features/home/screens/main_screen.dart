import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/features/settings/settings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const MainScreen(),
    );
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final _currentStream = context.read<MusicProvider>().current;
  final _controller = PageController();
  int _page = 0;

  @override
  void initState() {
    super.initState();

    context.read<DownloadManager>().setup();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Track?>(
      stream: _currentStream,
      builder: (context, snap) {
        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          appBar: [
            HomeAppBar(),
            SearchAppBar(),
            LibraryAppBar(),
            SettingsAppBar(),
          ][_page],
          bottomNavigationBar: MainBottomAppBar(
            page: _page,
            setPage: (page) {
              setState(() => _page = page);
              _controller.animateToPage(
                page,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: snap.hasData ? const MainFloatingMusicButton() : null,
          body: PageView(
            scrollBehavior: const ScrollBehavior().copyWith(
              overscroll: false,
              physics: const ClampingScrollPhysics(),
            ),
            onPageChanged: (page) => setState(() => _page = page),
            controller: _controller,
            children: const [
              HomeScreen(),
              SearchScreen(),
              LibraryScreen(),
              SettingsScreen(),
            ],
          ),
        );
      },
    );
  }
}
