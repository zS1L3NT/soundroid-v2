import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/utils/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends KeptAliveState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final searchProvider = context.watch<SearchProvider>();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      child: searchProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : searchProvider.results != null
              ? SearchResultsWidget(results: searchProvider.results!)
              : const Suggestions(),
    );
  }
}
