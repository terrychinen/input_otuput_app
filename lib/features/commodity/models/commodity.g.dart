// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commodity _$CommodityFromJson(Map<String, dynamic> json) {
  return Commodity(
    commodityId: json['commodity_id'] as int,
    commodityName: json['commodity_name'] as String,    
    categoryId: json['category_id'] as int,
    categoryName: json['category_name'] as String,
    storeId: json['store_id'] as int,
    storeName: json['store_name'] as String,
    stock: (json['stock'] as num)?.toDouble(),
    stockMin: (json['stock_min'] as num)?.toDouble(),
    stockTotal: (json['stock_total'] as num)?.toDouble(),
    state: json['state'] as int
  );
}

Map<String, dynamic> _$CommodityToJson(Commodity instance) => <String, dynamic>{
  'commodity_id': instance.commodityId,
  'commodity_name': instance.commodityName,
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'store_id': instance.storeId,
  'store_name': instance.storeName,
  'stock': instance.stock,
  'stock_min': instance.stockMin,
  'stock_total': instance.stockTotal,
  'state': instance.state
};