import 'package:firebase_auth/firebase_auth.dart';
import 'package:orot/pages/admin/components/districts_dropdown.dart';

enum UserPermission { admin, coordinator, volunteer }

class User {
  final String uid;
  final UserPermission permission;
  final String? name;
  final String? email;
  final District? district;

  User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.permission,
      this.district});

  factory User.fromJson(Map<String, dynamic> json) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    print('nigga what${json['district']}');
    return User(
        uid: json['uid'],
        permission: UserPermission.values.byName(json['permission']),
        name: json['name'] ?? auth.currentUser?.displayName,
        email: json['email'],
        district: json['district'] != null
            ? District(
                id: json['district']['id'], name: json['district']['name'])
            : null);
  }
}
