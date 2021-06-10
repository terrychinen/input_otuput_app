// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userId: json['employee_id'] as int,
    name: json['name'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
    environmentId: json['environment_id'] as int,
    environmentName: json['environment_name'] as String,
    state: json['state'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'employee_id': instance.userId,
  'name': instance.name,
  'username': instance.username,
  'password': instance.password,
  'environment_id': instance.environmentId,
  'environment_name': instance.environmentName,
  'state': instance.state,
};