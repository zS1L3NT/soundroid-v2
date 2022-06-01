import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/models/search.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/ui/widgets/app/text.dart';

class RecommendationItem extends StatelessWidget {
  const RecommendationItem({
    Key? key,
    required this.text,
    required this.icon,
    this.searchRef,
  }) : super(key: key);

  final String text;

  final IconData icon;

  final DocumentReference<Search>? searchRef;

  factory RecommendationItem.recent(String text, DocumentReference<Search> searchRef) {
    return RecommendationItem(
      text: text,
      icon: Icons.history_rounded,
      searchRef: searchRef,
    );
  }

  factory RecommendationItem.suggestion(String text) {
    return RecommendationItem(
      text: text,
      icon: Icons.music_note_rounded,
    );
  }

  void onClick(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();
    searchProvider.controller.text = text;
    searchProvider.query = text;
    searchProvider.search(context);
  }

  void onLongClick(BuildContext context) {
    if (searchRef != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete this search?"),
            content: const Text("This search record will be deleted."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () => deleteSearch(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((_) => Colors.red),
                ),
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
    }
  }

  void deleteSearch(BuildContext context) async {
    searchRef!.delete();
    Navigator.of(context).pop();
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
              Icon(icon, color: Colors.black87),
              const SizedBox(width: 16),
              Expanded(
                child: AppText.ellipse(text, fontSize: 18),
              ),
              IconButton(
                onPressed: () {
                  final searchProvider = context.read<SearchProvider>();
                  searchProvider.controller.text = text;
                  searchProvider.controller.selection =
                      TextSelection.collapsed(offset: text.length);
                  searchProvider.query = text;
                },
                icon: const Icon(Icons.north_west_rounded),
                color: Colors.black.withOpacity(0.7),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
