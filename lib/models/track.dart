import 'package:hive/hive.dart';

part 'track.g.dart';

@HiveType(typeId: 1)
class Track {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String artists;

  @HiveField(3)
  late String thumbnail;
}
