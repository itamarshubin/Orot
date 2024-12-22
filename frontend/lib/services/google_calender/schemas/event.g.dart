// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      start: EventTime.fromJson(json['start'] as Map<String, dynamic>),
      end: EventTime.fromJson(json['end'] as Map<String, dynamic>),
      attendees: (json['attendees'] as List<dynamic>?)
          ?.map((e) => EventAttended.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: json['summary'] as String? ?? "מפגש אורות",
      description: json['description'] as String?,
      location: json['location'] as String? ?? "בבית המשפחה",
      transparency: json['transparency'] as String? ?? "opaque",
      visibility: json['visibility'] as String? ?? "default",
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'summary': instance.summary,
      'description': instance.description,
      'location': instance.location,
      'attendees': instance.attendees,
      'transparency': instance.transparency,
      'visibility': instance.visibility,
    };
