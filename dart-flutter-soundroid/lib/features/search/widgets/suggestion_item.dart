import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/search/search.dart';
import 'package:soundroid/widgets/widgets.dart';

class SuggestionItem extends StatelessWidget {
  SuggestionItem({
    Key? key,
    required Suggestion suggestion,
  })  : text = suggestion.text,
        type = suggestion.type,
        icon = suggestion.type == SuggestionType.recent
            ? Icons.history_rounded
            : Icons.music_note_rounded,
        super(key: key);

  final String text;

  final IconData icon;

  final SuggestionType type;

  void onClick(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();
    searchProvider.controller.text = text;
    searchProvider.query = text;
    searchProvider.search(context);
  }

  void onLongClick(BuildContext context) {
    if (type == SuggestionType.recent) {
      AppConfirmDialog(
        title: "Delete this search?",
        description: "This search record will be deleted.",
        confirmText: "Delete",
        isDanger: true,
        onConfirm: () {
          context.read<SearchRepository>().deleteSearch(text);
          Navigator.of(context).pop();
        },
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(context),
      onLongPress: () => onLongClick(context),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              const SizedBox(width: 12),
              AppIcon.black87(icon),
              const SizedBox(width: 16),
              Expanded(
                child: AppText.ellipse(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              AppIcon.black87(
                Icons.north_west_rounded,
                onPressed: () {
                  final searchProvider = context.read<SearchProvider>();
                  searchProvider.controller.text = text;
                  searchProvider.controller.selection =
                      TextSelection.collapsed(offset: text.length);
                  searchProvider.query = text;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
