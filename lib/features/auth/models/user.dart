import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int userId;
  String name;
  String username;
  String password; 
  int state;

  User({
    this.userId,
    this.name,
    this.username,
    this.password,
    this.state
  });



  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}


