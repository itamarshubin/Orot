import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orot/modal/district_modal.dart';

class AdminService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> createCoordinator(
      {required String email,
      required String password,
      required String name,
      required String districtId}) async {
    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        districtId.isEmpty) {
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
    final callable = _functions.httpsCallable('createCoordinator');
    await callable.call({
      'email': email,
      'password': password,
      'name': name,
      'districtId': districtId
    });
    Fluttertoast.showToast(
      msg: "רכזת נוצרה בהצלחה",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
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

  Future<List<District>> getDistricts() async {
    try {
      final callable = _functions.httpsCallable('getDistricts');
      final results = await callable.call();

      return (results.data as List)
          .map((item) =>
              District(name: item['name'] as String, id: item['id'] as String))
          .toList();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return [];
    }
  }

  Future<void> createFamily(
      {required String name,
      required String address,
      required String contact,
      required String districtId}) async {
    if (name.isEmpty ||
        address.isEmpty ||
        contact.isEmpty ||
        districtId.isEmpty) {
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
      final callable = _functions.httpsCallable('createFamily');
      await callable.call({
        'name': name,
        'address': address,
        'contact': contact,
        'districtId': districtId
      });
      Fluttertoast.showToast(
        msg: "משפחה נוצרה בהצלחה",
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
