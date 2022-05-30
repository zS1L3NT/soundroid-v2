import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/helpers/api_helper.dart';
import 'package:soundroid/providers/search_provider.dart';

class SearchAppBar extends AppBar {
  SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<SearchProvider>().textEditingController = _controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.music_note_rounded),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (query) async {
                SearchProvider searchProvider = context.read<SearchProvider>();
                final dateTime = DateTime.now();
                searchProvider.query = query;
                searchProvider.results = null;

                final suggestions = await ApiHelper.fetchSearchSuggestions(searchProvider);
                searchProvider = context.read<SearchProvider>();
                if (dateTime.isAfter(searchProvider.latest) || dateTime == searchProvider.latest) {
                  searchProvider.latest = dateTime;
                  searchProvider.suggestions = suggestions;
                }
              },
              onEditingComplete: () => context.read<SearchProvider>().search(context),
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
        IconButton(
          onPressed: () {
            final searchProvider = context.read<SearchProvider>();
            searchProvider.query = "";
            searchProvider.results = null;
            _controller.clear();
          },
          icon: const Icon(Icons.clear_rounded),
          splashRadius: 20,
        )
      ],
      elevation: 10,
    );
  }
}
