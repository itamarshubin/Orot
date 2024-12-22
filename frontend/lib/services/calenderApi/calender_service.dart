import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:orot/services/auth_service.dart';

const String googleCalenderAPI = "https://www.googleapis.com/calender/v3";

Future addCalenderEvent(
    {required dynamic event, String calenderId = "primary"}) async {
  final String? userToken = await _getAuthToken();

  return await http.post(
    Uri.parse("$googleCalenderAPI/calenders/$calenderId/events"),
    headers: {
      "Authorization": "Bearer $userToken",
      "Content-Type": "application/json"
    },
    body: jsonEncode(event),
  );
}

Future updateCalenderEvent() async {
  // TODO: for future actions like update attendees.
}

Future<String?> _getAuthToken() async {
  final User? currentUser = AuthService().getCurrentUser();
  if (currentUser == null) throw "User is not logged in";
  // TODO: should call signin from auth_service
  final userIdToken = await currentUser.getIdToken();
  return userIdToken;
}
