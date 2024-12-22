import 'package:json_annotation/json_annotation.dart';

part 'event_time.g.dart';

@JsonSerializable()
class EventTime {
  DateTime dateTime;
  String? date; // formated like this yyyy-mm-dd
  String? timeZone;

  EventTime(
    this.dateTime, {
    this.date,
    this.timeZone,
  });

  factory EventTime.fromJson(Map<String, dynamic> json) =>
      _$EventTimeFromJson(json);

  Map<String, dynamic> toJson() => _$EventTimeToJson(this);
}
