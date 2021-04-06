import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:input_store_app/api_config.dart';
import 'package:input_store_app/features/auth/models/user.dart';

class AuthAPI {
  Future<Map<String, dynamic>> logIn(String username, 
    String password) async {
    try {
      final url = '${ApiConfig.apiUrl}/auth/signin';
      
      final response = await http.post(
            url,
            body: {'username': username, 'password': password}
          ).timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);

      final message = parseResponse['message'];
      final userResponse = parseResponse['user'];  

      if(response.statusCode == 200){
         User user = User.fromJson(userResponse);
        return {'ok': true, 'user': user, 'message': message};
      }
      return {'ok': false, 'message': message.toString()};
    }on PlatformException catch(e) {
      return {'ok': false, 'message': e.toString()};
    } on TimeoutException catch(_) {
      return {
        'ok': false, 
        'message': 'No se ha establecido la conexión con el servidor'
      };
    }
  }


    Future<Map<String, dynamic>> getUsers(int offset, int state) async {
    try {
      final url = '${ApiConfig.apiUrl}/employee?&offset=${offset.toString()}'+
        '&state=${state.toString()}';

      final response = await http.get(url).timeout(Duration(seconds: 20));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];

      if(response.statusCode == 200){
        final userResponse = parseResponse['result'] as List;

        List<User> userList = List<User>
          .from(userResponse.map((i) => User.fromJson(i)));

        return {'ok': true, 'result': userList};
      }
      return {'ok': false, 'message': message.toString()};
    }on PlatformException catch(e) {
      return {'ok': false, 'message': e.toString()};
    } on TimeoutException catch(_){
      return {
        'ok': false, 
        'message': 'No se ha establecido la conexión con el servidor'
      };  
    }
  }  
}