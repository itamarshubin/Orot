import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:orot/services/auth_service.dart';
import 'package:orot/services/google_calender/schemas/event.dart';
import 'package:orot/services/google_calender/schemas/event_attended.dart';

const String googleCalenderAPI = "https://www.googleapis.com/calender/v3";

Future addCalenderEvent(
  Event event, {
  String calenderId = "primary",
  bool addCurrentUser = true,
  String? accessToken,
}) async {
  final User? currentUser = AuthService().getCurrentUser();
  if (currentUser == null) throw "User is not logged in";
  // TODO: consider  calling signin from auth_service

  String? currentUserEmail = currentUser.email;
  if (addCurrentUser == true && currentUserEmail != null) {
    event.attendees?.add(EventAttended(
        currentUserEmail)); // note that the list empty bad things happens.
  }
  return await http.post(
    Uri.parse("$googleCalenderAPI/calenders/$calenderId/events"),
    headers: {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json"
    },
    body: jsonEncode(event.toJson()),
  );
}

Future updateCalenderEvent(Event updatedEvent) async {
  // TODO: for future actions like update attendees.
}
