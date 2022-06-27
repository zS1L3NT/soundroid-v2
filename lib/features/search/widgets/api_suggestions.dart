import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';

class ApiSuggestions extends StatelessWidget {
  const ApiSuggestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    final controller = AnimatedListController();

    // Animated items in the list reordering with this
    return AutomaticAnimatedListView<Suggestion>(
      list: searchProvider.suggestions,
      listController: controller,
      animator: const DefaultAnimatedListAnimator(
        dismissIncomingDuration: Duration(milliseconds: 300),
        resizeDuration: Duration(milliseconds: 300),
      ),
      comparator: AnimatedListDiffListComparator(
        sameItem: (a, b) => a.text == b.text,
        sameContent: (a, b) => a.type == b.type && a.text == b.text,
      ),
      itemBuilder: (context, suggestion, data) {
        return FadeTransition(
          opacity: data.animation,
          child: SuggestionItem(
            suggestion: suggestion,
          ),
        );
      },
    );
  }
}
