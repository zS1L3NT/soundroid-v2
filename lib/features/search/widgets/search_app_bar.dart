import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/widgets/widgets.dart';

class SearchAppBar extends AppBar {
  SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  void onTextChange(String query) async {
    SearchProvider searchProvider = context.read<SearchProvider>();
    final dateTime = DateTime.now();
    searchProvider.results = null;

    context.read<ApiRepository>().getSearchSuggestions(query).then((apiSuggestions) {
      searchProvider = context.read<SearchProvider>();
      if (dateTime.isAfter(searchProvider.latest) || dateTime == searchProvider.latest) {
        searchProvider.latest = dateTime;
        searchProvider.apiSuggestions = apiSuggestions;
      }
    });

    context.read<SearchRepository>().getRecentSearches(query).then(
      (recentSuggestions) {
        searchProvider = context.read<SearchProvider>();
        if (dateTime.isAfter(searchProvider.latest) || dateTime == searchProvider.latest) {
          searchProvider.latest = dateTime;
          searchProvider.recentSuggestions = recentSuggestions;
        }
      },
    );
  }

  void onTextClear() {
    final searchProvider = context.read<SearchProvider>();
    searchProvider.latest = DateTime.now();
    searchProvider.isLoading = false;
    searchProvider.query = "";
    searchProvider.results = null;
  }

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
              onChanged: onTextChange,
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
        context.watch<SearchProvider>().query != ""
            ? AppIcon(
                Icons.clear_rounded,
                onPressed: onTextClear,
              )
            : const SizedBox(),
        const SizedBox(width: 4)
      ],
    );
  }
}
