import 'package:flutter/material.dart';
import 'package:orot/models/family.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/services/volunteer_service.dart';

class VisitsProvider with ChangeNotifier {
  List<Visit> _upcomingVisits = [];

  List<Visit> get upcomingVisits => _upcomingVisits;

  Future<List<Visit>?> getUpcomingVisits() async {
    List<Visit>? upcomingVisits = await VolunteerService().getUpcomingVisits();
    if (upcomingVisits != null) {
      _upcomingVisits = upcomingVisits;
    }
    notifyListeners();
    return upcomingVisits;
  }

  Future<List<Visit>?> getVisitsHistory() async {
    List<Visit>? visitsHistory = await VolunteerService().getVisitsHistory();
    if (visitsHistory != null) {
      _upcomingVisits = visitsHistory;
    }
    notifyListeners();
    return visitsHistory;
  }
}
