class EventTime {
  String? date; // formated like this yyyy-mm-dd
  DateTime dateTime;
  String? timeZone;

  EventTime({
    required this.dateTime,
    this.date,
    this.timeZone,
  });

  Map<String, dynamic> toJson() => {
        "date": date,
        "dateTime": dateTime.toIso8601String(),
        "timeZone": timeZone,
      };
}

class Attended {
  String displayName;
  String email;

  Attended({
    required this.displayName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
      };
}

class CalenderEvent {
  EventTime start;
  EventTime end;
  String summary; // name of event
  String? description; // Could be built with HTML to display it nicely.
  String location; // location in string we will write the family's address
  List<Attended> attendees; // list of visitors and family.
  String transparency; // can be changed to "transparent" as well
  String visibility;

  CalenderEvent({
    this.summary = "מפגש אורות",
    required this.start,
    required this.end,
    required this.attendees,
    this.description,
    this.location = "בבית המשפחה",
    this.transparency = "opaque",
    this.visibility = "default",
  }); // cab be changed to public, private, confidential

  Map<String, dynamic> toJson() => {
        "start": start.toJson(),
        "end": end.toJson(),
        "summary": summary,
        "description": description,
        "location": location,
        "attendees": attendees.map((a) => a.toJson()).toList(),
        "transparency": transparency,
        "visibility": visibility,
      };
}
