import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

@JsonSerializable()
class Family {
  final String id;
  final String name;
  final String address;
  final String contact;

  Family(
      {required this.id,
      required this.name,
      required this.address,
      required this.contact});

  factory Family.fromJson(json) => Family(
        id: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        contact: json['contact'] as String,
      );

  Map<String, dynamic> toJson() => _$FamilyToJson(this);
}
