import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String picture;
  final bool verified;
  final List<String> likedTrackIds;

  const User({
    required this.name,
    required this.email,
    required this.picture,
    required this.verified,
    required this.likedTrackIds,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"],
        picture = json["picture"],
        verified = json["verified"],
        likedTrackIds = json["likedTrackIds"].cast<String>();

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'picture': picture,
        'verified': verified,
        'likedTrackIds': likedTrackIds,
      };

  @override
  List<Object?> get props => [
        name,
        email,
        picture,
        verified,
        likedTrackIds,
      ];
}
