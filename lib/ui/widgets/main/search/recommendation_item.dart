import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/ui/widgets/app/text.dart';

class RecommendationItem extends StatelessWidget {
  const RecommendationItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;

  final IconData icon;

  factory RecommendationItem.recent(String text) {
    return RecommendationItem(
      text: text,
      icon: Icons.history_rounded,
    );
  }

  factory RecommendationItem.suggestion(String text) {
    return RecommendationItem(
      text: text,
      icon: Icons.search_rounded,
    );
  }

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
