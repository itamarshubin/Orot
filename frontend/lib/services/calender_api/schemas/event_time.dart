import 'package:json_annotation/json_annotation.dart';

part 'event_time.g.dart';

@JsonSerializable()
class EventTime {
  String? date; // formated like this yyyy-mm-dd
  DateTime dateTime;
  String? timeZone;

  EventTime({
    required this.dateTime,
    this.date,
    this.timeZone,
  });

  factory EventTime.fromJson(Map<String, dynamic> json) =>
      _$EventTimeFromJson(json);

  Map<String, dynamic> toJson() => _$EventTimeToJson(this);
}
