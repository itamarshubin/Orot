import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:orot/models/user.dart';
import 'package:orot/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  String? get userName => _user?.name;

  UserPermission? get userPermission => _user?.permission;
  final _auth = firebase_auth.FirebaseAuth.instance;

  Future<User?> getUserData() async {
    if (_auth.currentUser == null) return _user;
    final response = await AuthService().getCurrentUser();
    if (response != null) {
      _user = User.fromJson(response);
    }
    notifyListeners();
    return _user;
  }
}
