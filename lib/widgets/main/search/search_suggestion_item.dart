import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/widgets/app/text.dart';

class SearchSuggestionItem extends StatefulWidget {
  final String text;
  const SearchSuggestionItem({Key? key, required this.text}) : super(key: key);

  @override
  State<SearchSuggestionItem> createState() => _SearchSuggestionItemState();
}

class _SearchSuggestionItemState extends State<SearchSuggestionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final search = context.read<SearchProvider>();
        search.textEditingController.text = widget.text;
        search.query = widget.text;
        search.onSearch();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.black87),
              const SizedBox(width: 16),
              AppText(
                widget.text,
                width: MediaQuery.of(context).size.width - 104,
                textAlign: TextAlign.left,
                fontSize: 18,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.north_west,
                  color: Colors.black.withOpacity(0.7),
                ),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
