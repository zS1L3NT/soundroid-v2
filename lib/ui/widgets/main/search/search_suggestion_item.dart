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
        final search = context.read<SearchProvider>();
        search.textEditingController.text = text;
        search.query = text;
        search.onSearch();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
          child: Row(
            children: [
              const Icon(Icons.search_rounded, color: Colors.black87),
              const SizedBox(width: 16),
              AppText.ellipse(
                text,
                width: MediaQuery.of(context).size.width - 104,
                fontSize: 18,
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
