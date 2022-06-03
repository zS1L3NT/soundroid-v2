import 'package:hive/hive.dart';

part 'artist.g.dart';

@HiveType(typeId: 1)
class Artist {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  Artist({
    required this.id,
    required this.name,
  });

  static Box<Artist> box = Hive.box<Artist>('artists');

  Artist.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
