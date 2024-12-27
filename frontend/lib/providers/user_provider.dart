import 'package:flutter/material.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/coordinator/show_volunteers/volunteers_page.dart';
import 'package:orot/pages/login/login_page.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';
import 'package:orot/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  String? get userName => _user?.name;

  UserPermission? get userPermission => _user?.permission;

  Future<void> getUserData() async {
    final response = await AuthService().getCurrentUser();
    if (response != null) {
      _user = User.fromJson(response);
    }
    notifyListeners();
  }

  Widget getUserStartPage() {
    if (_user == null) {
      return const LoginPage();
    } else if (_user!.permission == UserPermission.admin) {
      return const AdminPage();
    } else if (_user!.permission == UserPermission.coordinator) {
      return const VolunteersPage();
    } else if (_user!.permission == UserPermission.volunteer) {
      return const HomePage();
    }
    return Placeholder();
  }
}
