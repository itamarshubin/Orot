import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  final String id;
  final String name;

  District({
    required this.id,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
