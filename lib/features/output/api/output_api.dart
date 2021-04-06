import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:input_store_app/api_config.dart';
import 'package:input_store_app/features/output/models/output.dart';

class OutputAPI {
  Future<Map<String, dynamic>> getOutputs(String dateOutput, 
    int offset, int state) async {
    try {
      final url = '${ApiConfig.apiUrl}/output/phone/'+
        'search?date_output=$dateOutput&offset=${offset.toString()}'+
        '&state=${state.toString()}';

      final response = await http
        .get(url).timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];

      if(response.statusCode == 200){
        final outputResponse = parseResponse['result'] as List;
        List<Output> outputList = 
          List<Output>.from(outputResponse.map((i) 
            => Output.fromJson(i)));

        for(int i=0; i<outputList.length; i++) {
          Output output = outputList[i];
          output.outputDate = parseDate(output.outputDate);                      
        }

        return {'ok': true, 'result': outputList};
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

  String parseDate(String dateString) {
    if(dateString != null) {
      DateTime parsedDate = DateTime.parse(dateString);
      final DateFormat format = DateFormat('dd/MM/yyyy hh:mm a');
      return format.format(parsedDate);
    }

    return null;
  }


  Future<Map<String, dynamic>> createOutput(int storeID, 
    int commodityID, String note, double quantity, int employeeGives, 
    int employeeReceives, String dateOutput, int environmentID, 
    int state) async {
    try {
      final url = '${ApiConfig.apiUrl}/output';  

      final response = await http.post(
          url,
          body: {
            'store_id': storeID.toString(), 
            'commodity_id': commodityID.toString(),
            'environment_id': environmentID.toString(),
            'quantity': quantity.toString(),
            'employee_gives': employeeGives.toString(),
            'employee_receives': employeeReceives.toString(),
            'notes': note == null || note == '' ? '' : note,            
            'date_output': dateOutput,             
            'state': state.toString()
          }
      ) .timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];
      if(response.statusCode == 200){
        return {'ok': true, 'message': message.toString()};
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