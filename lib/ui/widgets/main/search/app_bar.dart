import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/helpers/api_helper.dart';
import 'package:soundroid/models/search.dart';
import 'package:soundroid/models/user.dart';
import 'package:soundroid/providers/search_provider.dart';

class SearchAppBar extends AppBar {
  SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  void onTextChange(String query) async {
    SearchProvider searchProvider = context.read<SearchProvider>();
    final dateTime = DateTime.now();
    searchProvider.query = query;
    searchProvider.results = null;

    ApiHelper.fetchSearchSuggestions(searchProvider).then((suggestions) {
      searchProvider = context.read<SearchProvider>();
      if (dateTime.isAfter(searchProvider.latest) || dateTime == searchProvider.latest) {
        searchProvider.latest = dateTime;
        searchProvider.suggestions = suggestions;
      }
    });

    Search.collection
        .where("userRef", isEqualTo: User.collection.doc("jnbZI9qOLtVsehqd6ICcw584ED93"))
        .where("query", isGreaterThanOrEqualTo: query)
        .where("query", isLessThanOrEqualTo: query + "~")
        .get()
        .then(
      (recents) {
        searchProvider = context.read<SearchProvider>();
        if (dateTime.isAfter(searchProvider.latest) || dateTime == searchProvider.latest) {
          searchProvider.latest = dateTime;
          searchProvider.recents = recents.docs;
        }
      },
    );
  }

  void onTextClear() {
    final searchProvider = context.read<SearchProvider>();
    searchProvider.query = "";
    searchProvider.results = null;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.search_rounded),
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
            ? IconButton(
                onPressed: onTextClear,
                icon: const Icon(Icons.clear_rounded),
                splashRadius: 20,
              )
            : const SizedBox(),
        const SizedBox(width: 4)
      ],
      elevation: 10,
    );
  }
}
