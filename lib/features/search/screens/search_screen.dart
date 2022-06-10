import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
              ? SearchResultsWidget(results: searchProvider.results!)
              : searchProvider.query != ""
                  ? const ApiSuggestions()
                  : const RecentSuggestions(),
    );
  }
}
