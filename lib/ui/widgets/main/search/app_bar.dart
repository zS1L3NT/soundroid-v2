import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:soundroid/models/search_result.dart';
import 'package:soundroid/providers/search_provider.dart';

class SearchAppBar extends AppBar {
  SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final _controller = TextEditingController();
  Future<List<String>>? _futureSuggestions;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<SearchProvider>().textEditingController = _controller;
    });
  }

  Future<List<String>> fetchSuggestions() async {
    final response = await http.get(Uri.parse(
        "http://localhost:5190/suggestions?query=" + context.read<SearchProvider>().query));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)["data"];
      return data.map((item) => item as String).toList();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch feed");
    }
  }

  Future<Map<String, List<SearchResult>>> fetchResults(SearchProvider searchProvider) async {
    searchProvider.isLoading = true;
    final response =
        await http.get(Uri.parse("http://localhost:5190/search?query=" + searchProvider.query));

    searchProvider.isLoading = false;
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body)["data"];
      return <String, List<SearchResult>>{
        "tracks": data["tracks"]!
            .map((tracks) => SearchResult.fromJson(Map.from(tracks)))
            .toList()
            .cast<SearchResult>(),
        "albums": data["albums"]!
            .map((albums) => SearchResult.fromJson(Map.from(albums)))
            .toList()
            .cast<SearchResult>(),
      };
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch feed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.music_note_rounded),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (query) async {
                final provider = Provider.of<SearchProvider>(context, listen: false);
                provider.query = query;
                provider.results = null;
                provider.suggestions = await fetchSuggestions();
              },
              onEditingComplete: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final searchProvider = Provider.of<SearchProvider>(context, listen: false);
                searchProvider.suggestions = null;
                searchProvider.results = await fetchResults(searchProvider);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search songs or albums...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<SearchProvider>().query = "";
            context.read<SearchProvider>().results = null;
            _controller.clear();
          },
          icon: const Icon(Icons.clear_rounded),
          splashRadius: 20,
        )
      ],
      elevation: 10,
    );
  }
}
