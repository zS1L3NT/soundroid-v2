import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';

class ApiSuggestions extends StatelessWidget {
  const ApiSuggestions({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AnimatedListController controller;

  @override
  Widget build(BuildContext context) {
    // Animated items in the list reordering with this
    return AutomaticAnimatedListView<Suggestion>(
      list: context.watch<SearchProvider>().suggestions,
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
