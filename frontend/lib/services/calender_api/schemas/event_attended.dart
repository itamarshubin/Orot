import 'package:json_annotation/json_annotation.dart';

part 'event_attended.g.dart';

@JsonSerializable()
class EventAttended {
  String displayName;
  String email;

  EventAttended({
    required this.displayName,
    required this.email,
  });

  factory EventAttended.fromJson(Map<String, dynamic> json) =>
      _$EventAttendedFromJson(json);

  Map<String, dynamic> toJson() => _$EventAttendedToJson(this);
}
