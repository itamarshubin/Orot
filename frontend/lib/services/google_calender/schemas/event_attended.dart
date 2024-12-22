import 'package:json_annotation/json_annotation.dart';

part 'event_attended.g.dart';

@JsonSerializable()
class EventAttended {
  String email;
  String? displayName;

  EventAttended(this.email, this.displayName);

  factory EventAttended.fromJson(Map<String, dynamic> json) =>
      _$EventAttendedFromJson(json);

  Map<String, dynamic> toJson() => _$EventAttendedToJson(this);
}
