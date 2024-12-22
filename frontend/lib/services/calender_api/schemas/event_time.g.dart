// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTime _$EventTimeFromJson(Map<String, dynamic> json) => EventTime(
      dateTime: DateTime.parse(json['dateTime'] as String),
      date: json['date'] as String?,
      timeZone: json['timeZone'] as String?,
    );

Map<String, dynamic> _$EventTimeToJson(EventTime instance) => <String, dynamic>{
      'date': instance.date,
      'dateTime': instance.dateTime.toIso8601String(),
      'timeZone': instance.timeZone,
    };
