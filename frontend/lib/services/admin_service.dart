import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> createUser() async {
    final callable = _functions.httpsCallable('createUser');
    final results = await callable.call();

    print(results.data);
  }

  Future<void> createCoordinator(
      {required String email,
      required String password,
      required String name}) async {
    final callable = _functions.httpsCallable('createCoordinator');
    await callable.call({'email': email, 'password': password, 'name': name});
  }

  Future<void> createDistrict({required String name}) async {
    final callable = _functions.httpsCallable('createDistrict');
    try {
      await callable.call({'name': name});
      Fluttertoast.showToast(
        msg: "מחוז נוצר בהצלחה",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
