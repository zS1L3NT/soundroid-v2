import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/ui/widgets/app/text.dart';

class SearchSuggestionItem extends StatelessWidget {
  const SearchSuggestionItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final searchProvider = context.read<SearchProvider>();
        searchProvider.textEditingController.text = text;
        searchProvider.query = text;
        searchProvider.search(context);
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
          child: Row(
            children: [
              const Icon(Icons.search_rounded, color: Colors.black87),
              const SizedBox(width: 16),
              Expanded(
                child: AppText.ellipse(text, fontSize: 18),
              ),
              IconButton(
                onPressed: () {
                  final search = context.read<SearchProvider>();
                  search.textEditingController.text = text;
                  search.textEditingController.selection =
                      TextSelection.collapsed(offset: text.length);
                  search.query = text;
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
