import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/search/search.dart';

class SearchProvider with ChangeNotifier {
  SearchProvider({
    required this.apiRepo,
    required this.searchRepo,
  });

  final ApiRepository apiRepo;
  final SearchRepository searchRepo;

  final _textEditingController = TextEditingController();
  TextEditingController get controller => _textEditingController;
  String get query => _textEditingController.text;

  set query(String? query) {
    if (query == null) {
      _textEditingController.clear();
    } else {
      _textEditingController.text = query;
      _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: query.length),
      );
    }

    handleTextChange(query ?? "");
  }

  DateTime _latest = DateTime.fromMicrosecondsSinceEpoch(0);
  DateTime get latest => _latest;

  set latest(DateTime latest) {
    _latest = latest;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  List<String> _recentSuggestions = [];
  List<String> _apiSuggestions = [];
  List<Suggestion> get suggestions => [
        ..._recentSuggestions.map(
          (suggestion) => Suggestion(
            type: SuggestionType.recent,
            text: suggestion,
          ),
        ),
        ..._apiSuggestions.where((suggestion) => !_recentSuggestions.contains(suggestion)).map(
              (suggestions) => Suggestion(
                type: SuggestionType.api,
                text: suggestions,
              ),
            ),
      ];

  set recentSuggestions(List<String> recentSuggestions) {
    _recentSuggestions = recentSuggestions;
    notifyListeners();
  }

  set apiSuggestions(List<String> apiSuggestions) {
    _apiSuggestions = apiSuggestions;
    notifyListeners();
  }

  SearchResults? _results;
  SearchResults? get results => _results;

  set results(SearchResults? results) {
    _results = results;
    notifyListeners();
  }

  void handleTextChange(String query) async {
    final dateTime = DateTime.now();
    _results = null;

    if (query == "") {
      _latest = dateTime;
      _isLoading = false;
      _apiSuggestions = [];
      notifyListeners();
      return;
    }

    apiRepo.getSearchSuggestions(query).then((apiSuggestions) {
      if (dateTime.isAfter(_latest) || dateTime == _latest) {
        _latest = dateTime;
        _apiSuggestions = apiSuggestions;
        notifyListeners();
      }
    });

    searchRepo.getRecentSearches(query).then(
      (recentSuggestions) {
        if (dateTime.isAfter(_latest) || dateTime == _latest) {
          _latest = dateTime;
          _recentSuggestions = recentSuggestions;
          notifyListeners();
        }
      },
    );
  }

  // This method is moved into the provider so it can be called from multiple places
  void search(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final dateTime = DateTime.now();
    _apiSuggestions = [];
    _isLoading = true;
    notifyListeners();

    final results = await apiRepo.getSearchResults(query);
    if (dateTime.isAfter(latest) || dateTime == latest) {
      _isLoading = false;
      _results = results;
      notifyListeners();
    }
  }
}
