import 'package:flutter/material.dart';
import 'package:orot/models/user.dart';
import 'package:orot/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  String? get userName => _user?.name;

  UserPermission? get userPermission => _user?.permission;

  Future<void> getUserData() async {
    final response = await AuthService().getCurrentUser();
    _user = User.fromJson(response);
    notifyListeners();
  }
}
