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
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<SearchProvider>().textEditingController =
          _textEditingController;
    });
  }

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
          controller: _textEditingController,
          onChanged: (query) {
            context.read<SearchProvider>().query = query;
            context.read<SearchProvider>().results = null;
          },
          onEditingComplete: context.read<SearchProvider>().onSearch,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search songs or albums...',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 16,
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
                context.read<SearchProvider>().query = "";
                context.read<SearchProvider>().results = null;
                _textEditingController.clear();
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
