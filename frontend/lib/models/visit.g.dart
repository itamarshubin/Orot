// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visit _$VisitFromJson(Map<dynamic, dynamic> json) => Visit(
      id: json['id'] as String,
      family: Family.fromJson(json['family'] as Map<String, dynamic>),
      visitDate: DateTime.parse(json['visitDate'] as String),
    );

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'id': instance.id,
      'family': instance.family,
      'visitDate': instance.visitDate.toIso8601String(),
    };
