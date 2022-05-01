import 'package:flutter/material.dart';
import 'package:soundroid/widgets/main/search/recent_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final history = [
    "iu lilac",
    "iu llac",
    "iu strawbrry moon",
    "mago gfriend",
    "invu taeyeon",
    "taeyeon",
    "weeekly holiday paty",
    "iu bluemin",
    "hotel del lna ost",
    "scarlet heart ost",
    "what's wrong with secretary kim ost",
    "it's okay to not be okay ost",
    "goblin the lonely and great god ost"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final search in history) RecentItem(text: search),
        ],
      ),
    );
  }
}
