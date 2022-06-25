import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/widgets/widgets.dart';

class SearchAppBar extends AppBar {
  SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const AppIcon(Icons.search_rounded),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: context.read<SearchProvider>().controller,
              onChanged: context.read<SearchProvider>().handleTextChange,
              onEditingComplete: () {
                context.read<SearchProvider>().search(context);
              },
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
            ),
          ),
        ],
      ),
      actions: [
        context.watch<SearchProvider>().query != ""
            ? AppIcon(
                Icons.clear_rounded,
                onPressed: () => context.read<SearchProvider>().query = "",
              )
            : const SizedBox(),
        const SizedBox(width: 4)
      ],
    );
  }
}
