// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Output _$OutputFromJson(Map<String, dynamic> json) {
  return Output(
    outputId: json['output_id'] as int,
    environmentId: json['environment_id'] as int,
    environmentName: json['environment_name'] as String,
    commodityId: json['commodity_id'] as int,
    commodityName: json['commodity_name'] as String,
    storeId: json['store_id'] as int,
    storeName: json['store_name'] as String,
    quantity: (json['quantity'] as num)?.toDouble(),
    employeeGivesId: json['employee_gives_id'] as int,
    employeeGivesName: json['employee_gives_name'] as String,
    employeeReceivesId: json['employee_receives_id'] as int,
    employeeReceivesName: json['employee_receives_name'] as String,
    outputDate: json['date_output'] as String,
    note: json['notes'] as String,
    state: json['state'] as int,
  );
}

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
  'output_id': instance.outputId,
  'environment_id': instance.environmentId,
  'environment_name': instance.environmentName,
  'commodity_id': instance.commodityId,
  'commodity_name': instance.commodityName,
  'store_id': instance.storeId,
  'store_name': instance.storeName,
  'quantity': instance.quantity,
  'employee_gives_id': instance.employeeGivesId,
  'employee_gives_name': instance.employeeGivesName,
  'employee_receives_id': instance.employeeReceivesId,
  'employee_receives_name': instance.employeeReceivesName,
  'output_date': instance.outputDate,
  'notes': instance.note,
  'state': instance.state,
};