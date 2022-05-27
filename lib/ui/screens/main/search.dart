import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/ui/widgets/main/search/recent_item.dart';
import 'package:soundroid/ui/widgets/main/search/search_suggestion_item.dart';
import 'package:soundroid/ui/widgets/app/list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchProvider>(context);
    return search.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: search.results != null
                ? search.results!["tracks"]!.length + search.results!["albums"]!.length
                : search.query.isEmpty
                    ? 0
                    : search.suggestions?.length ?? 0,
            itemBuilder: (context, index) {
              if (search.results != null) {
                final item = [...search.results!["tracks"]!, ...search.results!["albums"]!][index];
                return AppListItem.fromSearchResult(item, onTap: () {});
              }

              if (search.query.isEmpty) {
                return const RecentItem(text: "");
              }

              final suggestion = search.suggestions![index];
              return SearchSuggestionItem(text: suggestion);
            },
          );
  }
}
