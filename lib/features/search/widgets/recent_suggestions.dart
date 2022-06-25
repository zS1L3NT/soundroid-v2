import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/search/search.dart';

class RecentSuggestions extends StatefulWidget {
  const RecentSuggestions({Key? key}) : super(key: key);

  @override
  State<RecentSuggestions> createState() => _RecentSuggestionsState();
}

class _RecentSuggestionsState extends State<RecentSuggestions> {
  final _controller = AnimatedListController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Search>>(
      stream: context.read<SearchRepository>().getSearches(),
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

        return AutomaticAnimatedListView<Search>(
          list: snap.data!,
          listController: _controller,
          animator: const DefaultAnimatedListAnimator(
            dismissIncomingDuration: Duration(milliseconds: 300),
            resizeDuration: Duration(milliseconds: 300),
          ),
          comparator: AnimatedListDiffListComparator(
            sameItem: (a, b) => a.query == b.query,
            sameContent: (a, b) => a == b,
          ),
          itemBuilder: (context, search, data) {
            return FadeTransition(
              opacity: data.animation,
              child: SuggestionItem(
                suggestion: Suggestion(
                  type: SuggestionType.recent,
                  text: search.query,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
