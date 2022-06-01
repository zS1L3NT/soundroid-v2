import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/models/search.dart';
import 'package:soundroid/models/search_result.dart';
import 'package:soundroid/utils/server.dart';

class SearchProvider with ChangeNotifier {
  final _textEditingController = TextEditingController();
  DateTime _latest = DateTime.fromMicrosecondsSinceEpoch(0);
  bool _isLoading = false;
  List<DocumentSnapshot<Search>> _recents = [];
  List<String> _suggestions = [];
  Map<String, List<SearchResult>>? _results;

  TextEditingController get controller => _textEditingController;

  String get query => _textEditingController.text;

  DateTime get latest => _latest;

  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> get recommendations => [
        ..._recents.map(
          (r) => {
            "type": "recent",
            "data": r.data()!.query,
            "ref": r.reference,
          },
        ),
        ..._suggestions
            .where(
              (s) => _recents.indexWhere((r) => r.data()!.query == s) < 0,
            )
            .map(
              (s) => {
                "type": "suggestion",
                "data": s,
              },
            ),
      ];

  Map<String, List<SearchResult>>? get results => _results;

  set query(String? query) {
    if (query == null) {
      _textEditingController.clear();
    } else {
      _textEditingController.text = query;
      _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: query.length),
      );
    }
    notifyListeners();
  }

  set latest(DateTime latest) {
    _latest = latest;
    notifyListeners();
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set recents(List<DocumentSnapshot<Search>> recents) {
    _recents = recents;
    notifyListeners();
  }

  set suggestions(List<String> suggestions) {
    _suggestions = suggestions;
    notifyListeners();
  }

  set results(Map<String, List<SearchResult>>? results) {
    _results = results;
    notifyListeners();
  }

  // This method is moved into the provider so it can be called from multiple places
  void search(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final dateTime = DateTime.now();
    _suggestions = [];

    final results = await Server.fetchSearchResults(this);
    if (dateTime.isAfter(latest) || dateTime == latest) {
      _results = results;
    }
  }
}
