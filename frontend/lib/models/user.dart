import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orot/pages/volunteer/navigation.dart';

import '../pages/admin/admin_page.dart';
import '../pages/coordinator/show_volunteers/volunteers_page.dart';
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

  Widget getUserStartPage() {
    if (permission == UserPermission.admin) {
      return const AdminPage();
      // return '/management';
    } else if (permission == UserPermission.coordinator) {
      return const VolunteersPage();
      // return '/coordinator/home';
    } else if (permission == UserPermission.volunteer) {
      // return '/volunteer/home';
      return const VolunteerNavigation();
    }
    return Placeholder();
    // debugPrint('$permission');
  }
}
