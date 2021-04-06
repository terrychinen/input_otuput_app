import 'package:json_annotation/json_annotation.dart';
import 'package:input_store_app/features/commodity/models/commodity.dart';

part 'order_detail.g.dart';

@JsonSerializable()
class OrderDetail {
  int purchaseOrderId;
  int commodityId;
  String commodityName;
  double quantity;
  double unitPrice;
  double totalPrice;
  
  List<Commodity> commodityListSelected;

  OrderDetail({
    this.purchaseOrderId,
    this.commodityId,
    this.commodityName,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.commodityListSelected
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
  
}