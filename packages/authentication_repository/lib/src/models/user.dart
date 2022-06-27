import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

/// User model returned by Firestore
/// - `@CopyWith`
/// - `Equatable`
@CopyWith()
class User extends Equatable {
  const User({
    required this.name,
    required this.email,
    required this.picture,
    required this.verified,
    required this.likedTrackIds,
  });

  /// The display name of the User
  final String name;

  /// The email address of the User
  final String email;

  /// The profile picture of the User
  final String picture;

  /// Whether the User's email address has been verified
  final bool verified;

  /// The IDs of the Tracks the User has liked
  final List<String> likedTrackIds;

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

  @override
  String toString() {
    return "User { $name; $email; $verified; $likedTrackIds }";
  }
}
