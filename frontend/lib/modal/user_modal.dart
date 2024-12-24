import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;
  final String permission;
  final String? name;
  final String? email;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.permission,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return User(
      uid: json['uid'],
      permission: json['permission'],
      name: json['name'] ?? _auth.currentUser?.displayName,
      email: json['email'],
    );
  }
}
