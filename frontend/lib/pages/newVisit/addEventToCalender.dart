import 'dart:convert';

import 'package:http/http.dart' as http;

Future addEventToCalender(dynamic event, String accessToken) async {
  return await http.post(
    Uri.parse(
        "https://www.googleapis.com/calender/v3/calenders/primary/events"),
    headers: {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json"
    },
    body: jsonEncode(event),
  );
}
