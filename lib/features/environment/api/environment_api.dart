import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:input_store_app/api_config.dart';
import 'package:input_store_app/features/environment/models/models/environment.dart';

class EnvironmentAPI {
  Future<Map<String, dynamic>> getEnvironments(int offset,
    int state) async {
    try {
      final url = '${ApiConfig.apiUrl}/environment?'+
        'offset=${offset.toString()}&state=${state.toString()}';

      final response = await http
        .get(url).timeout(Duration(seconds: 20));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];

      if(response.statusCode == 200){
        final environmentResponse = parseResponse['result'] as List;
        List<Environment> environmentList = 
          List<Environment>.from(environmentResponse.map((i) 
            => Environment.fromJson(i)));

        return {'ok': true, 'result': environmentList};
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