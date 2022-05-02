import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';

class MainAppBar extends AppBar {
  final int screenIndex;
  MainAppBar({Key? key, required this.screenIndex}) : super(key: key);

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  final textEditingController = TextEditingController();

  @override
  AppBar build(BuildContext context) {
    Widget title = const Text("");
    List<Widget> actions = [];

    switch (widget.screenIndex) {
      case 0:
        title = const Text("SounDroid");
        actions.add(
          PopupMenuButton(
            onSelected: (item) {},
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "settings",
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey[800]),
                    const SizedBox(width: 8),
                    const Text("Settings"),
                  ],
                ),
              )
            ],
          ),
        );
        break;
      case 1:
        title = TextField(
          autofocus: true,
          controller: textEditingController,
          onChanged: context.read<SearchProvider>().setQuery,
          onEditingComplete: context.read<SearchProvider>().onSearch,
          decoration: InputDecoration(
            hintText: 'Search songs or albums...',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
          ),
        );
        if (context.watch<SearchProvider>().query != "") {
          actions.add(
            IconButton(
              onPressed: () {
                context.read<SearchProvider>().setQuery("");
                textEditingController.clear();
              },
              icon: const Icon(Icons.clear),
              splashRadius: 20,
            ),
          );
        }
        break;
      case 2:
        title = const Text("Library");
        break;
      case 3:
        title = const Text("Profile");
        break;
    }

    return AppBar(
      title: title,
      actions: actions,
      elevation: 10,
    );
  }
}
