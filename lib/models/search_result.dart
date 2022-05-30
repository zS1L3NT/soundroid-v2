class SearchResult {
  final String id;
  final String title;
  final List<String> artistIds;
  final String thumbnail;

  SearchResult({
    required this.id,
    required this.title,
    required this.artistIds,
    required this.thumbnail,
  });

  SearchResult.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        artistIds = json["artistIds"].cast<String>(),
        thumbnail = json["thumbnail"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "artistIds": artistIds,
        "thumbnail": thumbnail,
      };
}
