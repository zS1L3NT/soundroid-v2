class Artist {
  final String id;
  final String name;

  Artist({
    required this.id,
    required this.name,
  });

  Artist.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
