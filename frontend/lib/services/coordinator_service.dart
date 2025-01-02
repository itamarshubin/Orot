import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orot/models/family.dart';
import 'package:orot/models/user.dart';
import 'package:orot/models/visit.dart';

class CoordinatorService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> createVolunteer(
      {required String email,
      required String password,
      required String displayName,
      required String districtId,
      required String familyId}) async {
    if (email.isEmpty ||
        password.isEmpty ||
        displayName.isEmpty ||
        districtId.isEmpty ||
        familyId.isEmpty) {
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
        'districtId': districtId,
        'familyId': familyId
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

  Future<List<Family>> getFamilies(String? districtId) async {
    try {
      final callable = _functions.httpsCallable('getFamilies');
      final results = await callable.call({'districtId': districtId});
      print('this what we fucking got:${results.data}');

      return (results.data as List)
          .map((item) => Family.fromJson(item))
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

  Future<List<User>> getVolunteers() async {
    try {
      final callable = _functions.httpsCallable('getCoordinatorVolunteers');
      final results = await callable.call();

      return (results.data as List).map((item) => User.fromJson(item)).toList();
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

  Future<List<Visit>> getVisitData(String volunteerId) async {
    try {
      final callable = _functions.httpsCallable('getVisitsData');
      final results = await callable.call({'volunteerId': volunteerId});
      print('got res:${results.data}');

      return (results.data as List)
          .map((item) => Visit.fromJson(item))
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
}
