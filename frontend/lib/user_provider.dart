import 'package:flutter/material.dart';
import 'package:orot/modal/user_modal.dart';
import 'package:orot/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  String? get userName => _user?.name;

  Future<void> getUserData() async {
    final response = await AuthService().getCurrentUser();
    _user = User.fromJson(response);
    notifyListeners();
  }
}
