class Artist {
  final String id;
  final String name;
  final String picture;

  Artist({
    required this.id,
    required this.name,
    required this.picture,
  });

  Artist.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        picture = json["picture"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
      };
}
