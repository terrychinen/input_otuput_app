import 'package:json_annotation/json_annotation.dart';
part 'environment.g.dart';

@JsonSerializable()
class Environment {
  int environmentID;
  String name;
  int state;

  Environment({
    this.environmentID,
    this.name,
    this.state 
  });



  factory Environment.fromJson(Map<String, dynamic> json) 
    => _$EnvironmentFromJson(json);

  Map<String, dynamic> toJson() 
    => _$EnvironmentToJson(this);

}


