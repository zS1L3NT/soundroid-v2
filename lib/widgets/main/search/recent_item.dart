import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/widgets/app/text.dart';

class RecentItem extends StatefulWidget {
  final String text;
  const RecentItem({Key? key, required this.text}) : super(key: key);

  @override
  State<RecentItem> createState() => _RecentItemState();
}

class _RecentItemState extends State<RecentItem> {
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
              const Icon(Icons.history, color: Colors.black87),
              const SizedBox(width: 16),
              AppText(
                widget.text,
                type: TextType.ellipse,
                width: MediaQuery.of(context).size.width - 104,
                fontSize: 18,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.clear, color: Colors.black87),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
