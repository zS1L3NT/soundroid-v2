import 'package:hive/hive.dart';

part 'playlist.g.dart';

@HiveType(typeId: 0)
class Playlist {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String userId;

  @HiveField(2)
  late List<String> trackIds;
}
