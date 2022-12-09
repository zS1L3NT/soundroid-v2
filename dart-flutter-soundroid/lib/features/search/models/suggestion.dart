enum SuggestionType {
  recent,
  api,
}

class Suggestion {
  const Suggestion({
    required this.type,
    required this.text,
  });

  final SuggestionType type;

  final String text;
}
