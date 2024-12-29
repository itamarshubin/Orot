import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orot/models/visit.dart';

class VolunteerService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> createVisit({required DateTime dateTime}) async {
    final callable = _functions.httpsCallable('createVisit');
    try {
      await callable.call({
        'dateTime': dateTime.toIso8601String(),
      });
      Fluttertoast.showToast(
        msg: "פגישה נוצרה בהצלחה",
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

  Future<List<Visit>?> getUpcomingVisits() async {
    final callable = _functions.httpsCallable('getUpcomingVisits');
    try {
      final result = await callable.call();

      return (result.data as List)
          .map((visit) => Visit.fromJson(visit))
          .toList();
    } catch (e) {
      print('some fucking error:$e');
      return null;
    }
  }

  Future<List<Visit>?> getVisitsHistory() async {
    final callable = _functions.httpsCallable('getVisitsHistory');
    try {
      final result = await callable.call();

      return (result.data as List)
          .map((visit) => Visit.fromJson(visit))
          .toList();
    } catch (e) {
      print('some fucking error:$e');
      return null;
    }
  }
}
