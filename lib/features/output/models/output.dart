import 'package:json_annotation/json_annotation.dart';

part 'output.g.dart';

@JsonSerializable()
class Output {
  int outputId;
  int environmentId;
  String environmentName;
  int commodityId;
  String commodityName;
  int storeId;
  String storeName;
  double quantity;
  int employeeGivesId;
  String employeeGivesName;
  int employeeReceivesId;
  String employeeReceivesName;
  String outputDate;
  String note;
  int state;

  Output({
    this.outputId,
    this.environmentId,
    this.environmentName,
    this.commodityId,
    this.commodityName,
    this.storeId,
    this.storeName,
    this.quantity,
    this.employeeGivesId,
    this.employeeGivesName,
    this.employeeReceivesId,
    this.employeeReceivesName,
    this.outputDate,
    this.note,
    this.state
  });

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);
  Map<String, dynamic> toJson() => _$OutputToJson(this);

}