import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:orot/types/profiles.dart';

const String baseUrl = "http://10.0.2.2:5000";

Future<Profile> fetchProfile(String name) async {
  final res = await http.get(Uri.parse("$baseUrl/profiles/$name"));

  if (res.statusCode == 200) {
    return Profile.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to fetch joke');
  }
}

Future<FamilyProfile> fetchFamilyProfile(String name) async {
  final res = await http.get(Uri.parse("$baseUrl/profiles/$name/families"));

  if (res.statusCode == 200) {
    return FamilyProfile.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to fetch joke');
  }
}

Future fetchMeetingDates(String name) async {
  final res = await http.get(Uri.parse("$baseUrl/meetings/$name"));

  if (res.statusCode == 200) {
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  } else {
    throw Exception('Failed to fetch joke');
  }
}
