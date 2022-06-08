import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Stream<List<Search>> _searchesStream;

  Widget buildRecentSuggestionss(SearchProvider searchProvider) {
    return StreamBuilder<List<Search>>(
      stream: _searchesStream,
      builder: (context, snap) {
        if (snap.hasError) {
          debugPrint(snap.error.toString());
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (!snap.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snap.data!.length,
          itemBuilder: (context, index) {
            return SuggestionItem(
              suggestion: Suggestion(
                type: SuggestionType.recent,
                text: snap.data![index].query,
              ),
            );
          },
        );
      },
    );
  }

  Widget buildApiSuggestions(SearchProvider searchProvider) {
    return ListView.builder(
      itemCount: searchProvider.suggestions.length,
      itemBuilder: (context, index) {
        return SuggestionItem(
          suggestion: searchProvider.suggestions[index],
        );
      },
    );
  }

  Widget buildSearchResults(SearchProvider searchProvider) {
    return ListView.builder(
      itemCount: searchProvider.results!.tracks.length + searchProvider.results!.albums.length,
      itemBuilder: (context, index) {
        final results = [...searchProvider.results!.tracks, ...searchProvider.results!.albums];
        final result = results[index];

        if (result is Track) {
          return AppListItem.fromTrack(result, onTap: () {});
        }

        if (result is Album) {
          return AppListItem.fromAlbum(result, onTap: () {});
        }

        throw Error();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      child: searchProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : searchProvider.results != null
              ? buildSearchResults(searchProvider)
              : searchProvider.query != ""
                  ? buildApiSuggestions(searchProvider)
                  : buildRecentSuggestionss(searchProvider),
    );
  }
}

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

    // Server.fetchSearchSuggestions(searchProvider).then((suggestions) {
    // searchProvider = context.read<SearchProvider>();
    // if (dateTime.isAfter(searchProvider.latest) || dateTime == searchProvider.latest) {
    // searchProvider.latest = dateTime;
    // searchProvider.suggestions = suggestions;
    // }
    // });

    // Search.collection
    // .where("userRef", isEqualTo: User.collection.doc("jnbZI9qOLtVsehqd6ICcw584ED93"))
    // .where("query", isGreaterThanOrEqualTo: query)
    // .where("query", isLessThanOrEqualTo: query + "~")
    // .get()
    // .then(
    // (recents) {
    // searchProvider = context.read<SearchProvider>();
    // if (dateTime.isAfter(searchProvider.latest) || dateTime == searchProvider.latest) {
    // searchProvider.latest = dateTime;
    // searchProvider.recents = recents.docs;
    // }
    // },
    // );
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

class SuggestionItem extends StatelessWidget {
  SuggestionItem({
    Key? key,
    required Suggestion suggestion,
  })  : text = suggestion.text,
        type = suggestion.type,
        icon = suggestion.type == SuggestionType.recent
            ? Icons.history_rounded
            : Icons.music_note_rounded,
        super(key: key);

  final String text;

  final IconData icon;

  final SuggestionType type;

  void onClick(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();
    searchProvider.controller.text = text;
    searchProvider.query = text;
    searchProvider.search(context);
  }

  void onLongClick(BuildContext context) {
    if (type == SuggestionType.recent) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete this search?"),
            content: const Text("This search record will be deleted."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => deleteSearch(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((_) => Colors.red),
                ),
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
    }
  }

  void deleteSearch(BuildContext context) async {
    // searchRef!.delete();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(context),
      onLongPress: () => onLongClick(context),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              const SizedBox(width: 12),
              AppIcon.black87(icon),
              const SizedBox(width: 16),
              Expanded(
                child: AppText.ellipse(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              AppIcon.black87(
                Icons.north_west_rounded,
                onPressed: () {
                  final searchProvider = context.read<SearchProvider>();
                  searchProvider.controller.text = text;
                  searchProvider.controller.selection =
                      TextSelection.collapsed(offset: text.length);
                  searchProvider.query = text;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
