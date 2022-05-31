import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/ui/widgets/app/text.dart';

class RecentItem extends StatelessWidget {
  const RecentItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final searchProvider = context.read<SearchProvider>();
        searchProvider.controller.text = text;
        searchProvider.query = text;
        searchProvider.search(context);
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
          child: Row(
            children: [
              const Icon(Icons.history_rounded, color: Colors.black87),
              const SizedBox(width: 16),
              Expanded(
                child: AppText.ellipse(text, fontSize: 18),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.clear_rounded, color: Colors.black87),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
