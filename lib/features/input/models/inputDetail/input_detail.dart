import 'package:json_annotation/json_annotation.dart';

part 'input_detail.g.dart';

@JsonSerializable()
class InputDetail {
  int purchaseOrderId;
  int employeeId;
  String username;
  int providerId;
  String providerName;
  int storeId;
  String storeName;
  int commodityId;
  String commodityName;
  double quantity;  
  String inputDate;  

  InputDetail({
    this.purchaseOrderId,
    this.employeeId,
    this.username,
    this.providerId,
    this.providerName,
    this.storeId,
    this.storeName,
    this.commodityId,
    this.commodityName,
    this.quantity,
    this.inputDate,
  });

  factory InputDetail.fromJson(Map<String, dynamic> json) => _$InputDetailFromJson(json);
  Map<String, dynamic> toJson() => _$InputDetailToJson(this);

}