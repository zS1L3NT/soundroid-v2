import 'package:hive/hive.dart';

part 'listen.g.dart';

@HiveType(typeId: 2)
class Listen {
  @HiveField(0)
  late String trackId;

  @HiveField(1)
  late String userId;

  @HiveField(2)
  late String startTime;

  @HiveField(3)
  late String endTime;
}
