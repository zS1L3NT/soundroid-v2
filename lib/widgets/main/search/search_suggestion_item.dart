import 'package:flutter/material.dart';
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 56),
        child: AppText(
          widget.text,
          width: MediaQuery.of(context).size.width - 104,
          height: 36,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 18,
            height: 1.7,
          ),
        ),
      ),
    );
  }
}
