// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Input _$InputFromJson(Map<String, dynamic> json) {
  return Input(
    purchaseOrderId: json['purchase_order_id'] as int,
    employeeId: json['employee_id'] as int,
    employeeName: json['employee_name'] as String,
    providerId: json['prvoider_id'] as int,
    providerName: json['provider_name'] as String,
    inputDate: json['input_date'] as String,
    note: json['notes'] as String,
    state: json['state'] as int,
  );
}

Map<String, dynamic> _$InputToJson(Input instance) => <String, dynamic>{
  'purchase_order_id': instance.purchaseOrderId,
  'employee_id': instance.employeeId,
  'input_date': instance.inputDate,
  'notes': instance.note,
  'state': instance.state,
};