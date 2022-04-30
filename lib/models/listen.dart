class Listen {
  final String trackId;
  final String userId;
  final int startTime;
  final int endTime;

  Listen({
    required this.trackId,
    required this.userId,
    required this.startTime,
    required this.endTime,
  });

  static Listen fromJSON(Map<String, dynamic> json) => Listen(
        trackId: json["trackId"],
        userId: json["userId"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJSON() => <String, dynamic>{
        "trackId": trackId,
        "userId": userId,
        "startTime": startTime,
        "endTime": endTime
      };
}
