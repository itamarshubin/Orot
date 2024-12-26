import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

import 'district.dart';

part 'user.g.dart';

enum UserPermission { admin, coordinator, volunteer }

@JsonSerializable()
class User {
  final String uid;
  final UserPermission permission;
  final String? name;
  final String? email;
  final District? district;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.permission,
    this.district,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
