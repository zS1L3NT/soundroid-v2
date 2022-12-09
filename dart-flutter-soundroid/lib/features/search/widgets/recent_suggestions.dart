import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/widgets/widgets.dart';

class RecentSuggestions extends StatelessWidget {
  const RecentSuggestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = AnimatedListController();

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

        if (snap.data!.isEmpty) {
          return Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, kToolbarHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcon.primaryColor(
                  Icons.search_rounded,
                  size: 48,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Your search history will\nshow up here!",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        }

        // Animated items in the list reordering with this
        return AutomaticAnimatedListView<Search>(
          list: snap.data!,
          listController: controller,
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
