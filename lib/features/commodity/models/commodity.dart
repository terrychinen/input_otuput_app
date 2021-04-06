import 'package:json_annotation/json_annotation.dart';

part 'commodity.g.dart';

@JsonSerializable()
class Commodity {
  int commodityId;
  String commodityName;
  int categoryId;
  String categoryName;
  int storeId;
  String storeName;
  double stock;
  double stockMin;
  double stockTotal;
  int state;

  Commodity({
    this.commodityId,
    this.commodityName,
    this.categoryId,
    this.categoryName,
    this.storeId,
    this.storeName,
    this.stock,
    this.stockMin,
    this.stockTotal,
    this.state
  });

  factory Commodity.fromJson(Map<String, dynamic> json) => _$CommodityFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityToJson(this);
}