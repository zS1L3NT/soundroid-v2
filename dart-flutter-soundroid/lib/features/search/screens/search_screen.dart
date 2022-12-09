import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends KeptAliveState<SearchScreen> {
  final _controller = AnimatedListController();

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
          : searchProvider.hasError
              ? Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, kToolbarHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon.red(
                        Icons.cloud_off_rounded,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Could not fetch search results from\nthe SounDroid server!",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              : searchProvider.results != null
                  ? SearchResultsWidget(results: searchProvider.results!)
                  : searchProvider.query != ""
                      ? ApiSuggestions(controller: _controller)
                      : const RecentSuggestions(),
    );
  }
}
