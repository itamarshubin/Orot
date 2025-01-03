// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'permission': _$UserPermissionEnumMap[instance.permission]!,
      'name': instance.name,
      'district': instance.district,
    };

const _$UserPermissionEnumMap = {
  UserPermission.admin: 'admin',
  UserPermission.coordinator: 'coordinator',
  UserPermission.volunteer: 'volunteer',
};
