// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail(
    purchaseOrderId: json['purchase_order_id'] as int,
    commodityId: json['commodity_id'] as int,
    commodityName: json['name'] as String,
    quantity: (json['quantity'] as num)?.toDouble(),
    unitPrice: (json['unit_price'] as num)?.toDouble(),
    totalPrice: (json['total_price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) => <String, dynamic>{
  'purchase_order_id': instance.purchaseOrderId,
  'commodity_id': instance.commodityId,
  'name': instance.commodityName,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
  'total_price': instance.totalPrice,
};