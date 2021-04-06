import 'package:json_annotation/json_annotation.dart';

part 'output.g.dart';

@JsonSerializable()
class Output {
  int outputId;
  int environmentId;
  String environmentName;
  int commodityId;
  String commodityName; 
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


/*
output_id: number;
    store_id: number;
    commodity_id: number;
    environment_id: number;
    quantity: number;
    employee_gives: number;
    employee_receives: number;
    date_output: string;
    notes: string;
    state: number;


*/