// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Environment _$EnvironmentFromJson(
    Map<String, dynamic> json) {
  return Environment(
    environmentID: json['environment_id'] as int,
    name: json['name'] as String,
    state: json['state'] as int,
  );
}

Map<String, dynamic> _$EnvironmentToJson(
    Environment instance) => <String, dynamic>{
  'environment_id': instance.environmentID,
  'name': instance.name,
  'state': instance.state,
};