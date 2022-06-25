import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();

    return ListView.builder(
      itemCount: searchProvider.suggestions.length,
      itemBuilder: (context, index) {
        return SuggestionItem(
          suggestion: searchProvider.suggestions[index],
        );
      },
    );
  }
}
