import 'package:json_annotation/json_annotation.dart';
import 'package:orot/components/dropdown.dart';

part 'family.g.dart';

@JsonSerializable()
class Family extends DropdownItem {
  @override
  final String id;
  @override
  final String name;
  final String address;
  final String contact;

  Family(
      {required this.id,
      required this.name,
      required this.address,
      required this.contact});

  factory Family.fromJson(json) {
    return Family(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      contact: json['contact'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$FamilyToJson(this);
}
