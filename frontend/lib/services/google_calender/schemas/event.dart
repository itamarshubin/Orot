import 'package:json_annotation/json_annotation.dart';
import 'package:orot/services/google_calender/schemas/event_attended.dart';
import 'package:orot/services/google_calender/schemas/event_time.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  EventTime start;
  EventTime end;
  String summary; // name of event
  String? description; // Could be built with HTML to display it nicely.
  String location; // location in string we will write the family's address
  List<EventAttended>? attendees; // list of visitors and family.
  String transparency; // can be changed to "transparent" as well
  String visibility;

  Event({
    required this.start,
    required this.end,
    this.attendees,
    this.summary = "מפגש אורות",
    this.description,
    this.location = "בבית המשפחה",
    this.transparency = "opaque",
    this.visibility = "default",
  }); // cab be changed to public, private, confidential

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
