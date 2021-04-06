// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputDetail _$InputDetailFromJson(Map<String, dynamic> json) {
  return InputDetail(
    purchaseOrderId: json['purchase_order_id'] as int,
    employeeId: json['employee_id'] as int,
    username: json['username'] as String,
    providerId: json['prvoider_id'] as int,
    providerName: json['provider_name'] as String,
    storeId: json['store_id'] as int,
    storeName: json['store_name'] as String,
    commodityId: json['commodity_id'] as int,
    commodityName: json['commodity_name'] as String,
    quantity: (json['quantity'] as num)?.toDouble(),
    inputDate: json['input_date'] as String,
  );
}

Map<String, dynamic> _$InputDetailToJson(InputDetail instance) => <String, dynamic>{
  'purchase_order_id': instance.purchaseOrderId,
  'employee_id': instance.employeeId,
  'username': instance.username,
  'provider_id': instance.providerId,
  'provider_name': instance.providerName,
  'store_id': instance.storeId,
  'store_name': instance.storeName,
  'commodity_id': instance.commodityId,
  'commodity_name': instance.commodityName,
  'quantity': instance.quantity,
  'input_date': instance.inputDate,
};