import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int purchaseOrderId;
  int employeeId;
  String employeeName;
  int providerId;
  String providerName;
  String orderDate;
  String receiveDate;
  String paidDate;
  String cancelDate;
  double totalPrice;
  String note;
  int state;

  Order({
    this.purchaseOrderId,
    this.employeeId,
    this.employeeName,
    this.providerId,
    this.providerName,
    this.orderDate,
    this.receiveDate,
    this.paidDate,
    this.cancelDate,
    this.totalPrice,
    this.note,
    this.state
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

}