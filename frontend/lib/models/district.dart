import 'package:json_annotation/json_annotation.dart';
import 'package:orot/components/dropdown.dart';

part 'district.g.dart';

@JsonSerializable()
class District extends DropdownItem {
  @override
  final String id;
  @override
  final String name;

  District({
    required this.id,
    required this.name,
  });

  factory District.fromJson(json) => District(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
