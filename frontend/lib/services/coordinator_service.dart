import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CoordinatorService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createVolunteer(
      {required String email,
      required String password,
      required String displayName}) async {
    if (email.isEmpty || password.isEmpty || displayName.isEmpty) {
      Fluttertoast.showToast(
        msg: "אחד או יותר מהשדות ריקים",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return;
    }
    try {
      final callable = _functions.httpsCallable('createVolunteer');
      await callable.call({
        'email': email,
        'password': password,
        'displayName': displayName,
      });
      Fluttertoast.showToast(
        msg: "משתמש נוצר בהצלחה",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? e.code,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
