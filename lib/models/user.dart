import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundroid/models/search.dart';

class User {
  final String name;
  final String email;
  final String picture;
  final bool verified;
  final List<String> likedTrackIds;

  User({
    required this.name,
    required this.email,
    required this.picture,
    required this.verified,
    required this.likedTrackIds,
  });

  static CollectionReference<User> collection =
      FirebaseFirestore.instance.collection("users").withConverter(
            fromFirestore: (snap, _) => User.fromJson(snap.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

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
}
