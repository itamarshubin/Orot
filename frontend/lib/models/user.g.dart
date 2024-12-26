// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return User(
    uid: json['uid'] as String,
    name: json['name'] ?? auth.currentUser?.displayName,
    email: json['email'] as String?,
    permission: $enumDecode(_$UserPermissionEnumMap, json['permission']),
    district: json['district'] == null
        ? null
        : District.fromJson(json['district'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'permission': _$UserPermissionEnumMap[instance.permission]!,
      'name': instance.name,
      'email': instance.email,
      'district': instance.district,
    };

const _$UserPermissionEnumMap = {
  UserPermission.admin: 'admin',
  UserPermission.coordinator: 'coordinator',
  UserPermission.volunteer: 'volunteer',
};
