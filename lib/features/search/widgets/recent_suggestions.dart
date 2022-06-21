import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/search/search.dart';

class RecentSuggestions extends StatelessWidget {
  const RecentSuggestions({Key? key}) : super(key: key);

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
}
