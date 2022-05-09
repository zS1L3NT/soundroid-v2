import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';

class SearchAppBar extends AppBar {
  SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<SearchProvider>().textEditingController = _textEditingController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
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
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<SearchProvider>().query = "";
            context.read<SearchProvider>().results = null;
            _textEditingController.clear();
          },
          icon: const Icon(Icons.clear),
          splashRadius: 20,
        )
      ],
      elevation: 10,
    );
  }
}
