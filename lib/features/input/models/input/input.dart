import 'package:json_annotation/json_annotation.dart';

part 'input.g.dart';

@JsonSerializable()
class Input {
  int purchaseOrderId;
  int employeeId;
  String employeeName;
  int providerId;
  String providerName;
  String inputDate;  
  String note;
  int state;
  String orderDate;
  String receiveDate;
  double totalPrice;

  Input({
    this.purchaseOrderId,
    this.employeeId,
    this.employeeName,
    this.providerId,
    this.providerName,
    this.inputDate,
    this.note,
    this.state,
    this.orderDate,
    this.receiveDate,
    this.totalPrice
  });

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);
  Map<String, dynamic> toJson() => _$InputToJson(this);

}