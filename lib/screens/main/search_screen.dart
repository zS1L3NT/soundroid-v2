import 'package:flutter/material.dart';
import 'package:soundroid/widgets/main/search/recent_item.dart';
import 'package:soundroid/widgets/main/search/search_suggestion_item.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final history = [
    "iu lilac",
    "iu llac",
    "iu strawbrry moon",
    "mago gfriend",
    "invu taeyeon",
    "taeyeon",
    "weeekly holiday paty",
    "iu bluemin",
    "hotel del lna ost",
    "scarlet heart ost",
    "what's wrong with secretary kim ost",
    "it's okay to not be okay ost",
    "goblin the lonely and great god ost"
  ];

  final searchSuggestionsApiData = const [
    "iu lilac",
    "iu lilac cover english a b c d e f g",
    "iu lilac live",
    "iu lilac slowed and reverb",
    "iu lilac album",
    "iu lilac edit audio",
    "iu lilac for 1 hour"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.query.isEmpty
            ? [for (final search in history) RecentItem(text: search)]
            : [
                for (final suggestion in searchSuggestionsApiData)
                  SearchSuggestionItem(text: suggestion)
              ],
      ),
    );
  }
}
