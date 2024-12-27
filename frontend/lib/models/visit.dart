import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orot/models/family.dart';

part 'visit.g.dart';

@JsonSerializable()
class Visit {
  final String id;
  final Family family;
  final DateTime visitDate;

  Visit({required this.id, required this.family, required this.visitDate});

  factory Visit.fromJson(json) => Visit(
        id: json['id'] as String,
        family: Family.fromJson(json['family']),
        visitDate: DateTime.parse(json['visitDate'] as String),
      );

  Map<String, dynamic> toJson() => _$VisitToJson(this);
}
