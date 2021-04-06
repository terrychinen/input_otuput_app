// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    purchaseOrderId: json['purchase_order_id'] as int,
    employeeId: json['employee_id'] as int,
    employeeName: json['employee_name'] as String,
    providerId: json['prvoider_id'] as int,
    providerName: json['provider_name'] as String,
    orderDate: json['order_date'] as String,
    receiveDate: json['receive_date'] as String,
    paidDate: json['paid_date'] as String,
    cancelDate: json['cancel_date'] as String,
    totalPrice: (json['total_price'] as num)?.toDouble(),
    note: json['notes'] as String,
    state: json['state'] as int,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'purchase_order_id': instance.purchaseOrderId,
  'employee_id': instance.employeeId,
  'order_date': instance.orderDate,
  'receive_date': instance.receiveDate,
  'paid_date': instance.paidDate,
  'cancel_date': instance.cancelDate,
  'total_price': instance.totalPrice,
  'notes': instance.note,
  'state': instance.state,
};