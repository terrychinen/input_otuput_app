import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:input_store_app/api_config.dart';
import 'package:input_store_app/features/input/models/input/input.dart';
import 'package:input_store_app/features/input/models/inputDetail/input_detail.dart';

class InputAPI {

  Future<Map<String, dynamic>> getInputs(String inputDate) async {
    try {
      final url = '${ApiConfig.apiUrl}/input/phone/order/search?input_date=$inputDate';

      final response = await http.get(url).timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];

      if(response.statusCode == 200){
        final inputResponse = parseResponse['result'] as List;
        List<Input> inputList = List<Input>.from(inputResponse.map((i) => Input.fromJson(i)));

        for(int i=0; i<inputList.length; i++) {
          Input input = inputList[i];
          input.inputDate = parseDate(input.inputDate);
          input.orderDate = parseDate(input.orderDate);
          input.receiveDate = parseDate(input.receiveDate);
        }

        return {'ok': true, 'result': inputList};
      }
      return {'ok': false, 'message': message.toString()};
    }on PlatformException catch(e) {
      return {'ok': false, 'message': e.toString()};
    } on TimeoutException catch(_){
      return {'ok': false, 'message': 'No se ha establecido la conexión con el servidor'};  
    }
  }



  Future<Map<String, dynamic>> getInput(int orderID) async {
    try {
      final url = '${ApiConfig.apiUrl}/input/${orderID.toString()}';

      final response = await http.post(url).timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];

      print(response.body);

      if(response.statusCode == 200){
        final inputResponse = parseResponse['result'] as List;
        List<Input> inputList = List<Input>.from(inputResponse.map((i) => Input.fromJson(i)));

        return {'ok': true, 'result': inputList};
      }
      return {'ok': false, 'message': message.toString()};
    }on PlatformException catch(e) {
      return {'ok': false, 'message': e.toString()};
    } on TimeoutException catch(_){
      return {'ok': false, 'message': 'No se ha establecido la conexión con el servidor'};  
    }
  }



  Future<Map<String, dynamic>> createInput(int orderID, 
  int employeeID, String inputDate) async {
    try {
      final url = '${ApiConfig.apiUrl}/input/phone/create';  

      final response = await http.post(
          url,
          body: {
            'purchase_order_id': orderID.toString(), 
            'employee_id': employeeID.toString(),
            'input_date': inputDate.toString(),
            'notes': '',
            'state': '1'
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
 


  Future<Map<String, dynamic>> updateInput(int orderID, String inputDate, String note) async {
    
    try {
      final url = '${ApiConfig.apiUrl}/input';

      final response = await http.put(
          url,
          body: {
            'order_id': orderID.toString(),
            'notes': note == null || note == '' ? '' : note,
            'input_date': inputDate
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



  Future<Map<String, dynamic>> createInputDetail(int orderID, int commodityID, 
  int storeID, double quantity) async {
    
    try {
      final url = '${ApiConfig.apiUrl}/input/phone/create/detail';

      final response = await http.post(
          url,
          body: {
            'purchase_order_id': orderID.toString(),
            'store_id': storeID.toString(),
            'commodity_id': commodityID.toString(),
            'quantity': quantity.toString()
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



  Future<Map<String, dynamic>> getInputDetailByDate(String inputDate) async {
    try {
      final url = '${ApiConfig.apiUrl}/input/phone/detail/search/?input_date=$inputDate';

      final response = await http.get(url).timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];     

      if(response.statusCode == 200){
        final inputDetailResponse = parseResponse['result'] as List;
        
        List<InputDetail> inputDetailList = List<InputDetail>
          .from(inputDetailResponse.map((i) => InputDetail.fromJson(i)));

        for(int i=0; i<inputDetailList.length; i++) {
          InputDetail inputDetail = inputDetailList[i];
          inputDetail.inputDate = parseDate(inputDetail.inputDate);                      
        }

        return {'ok': true, 'result': inputDetailList};
      }
      return {'ok': false, 'message': message.toString()};
    }on PlatformException catch(e) {
      return {'ok': false, 'message': e.toString()};
    } on TimeoutException catch(_){
      return {'ok': false, 'message': 'No se ha establecido la conexión con el servidor'};  
    }
  }



  Future<Map<String, dynamic>> getInputDetailByID(int orderID) async {
    try {
      final url = '${ApiConfig.apiUrl}/input/${orderID.toString()}?offset=0';

      final response = await http.get(url).timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];     

      if(response.statusCode == 200){
        final inputDetailResponse = parseResponse['result'] as List;
        
        List<InputDetail> inputDetailList = List<InputDetail>
          .from(inputDetailResponse.map((i) => InputDetail.fromJson(i)));

        for(int i=0; i<inputDetailList.length; i++) {
          InputDetail inputDetail = inputDetailList[i];
          inputDetail.inputDate = parseDate(inputDetail.inputDate);                      
        }

        return {'ok': true, 'result': inputDetailList};
      }
      return {'ok': false, 'message': message.toString()};
    }on PlatformException catch(e) {
      return {'ok': false, 'message': e.toString()};
    } on TimeoutException catch(_){
      return {'ok': false, 'message': 'No se ha establecido la conexión con el servidor'};  
    }
  }
  


  Future<Map<String, dynamic>> deleteInputDetail(int orderID, int commodityID, 
  int storeID) async {
    
    try {
      final url = '${ApiConfig.apiUrl}/input/phone/delete/detail';

      final response = await http.post(
          url,
          body: {
            'order_id': orderID.toString(),
            'store_id': storeID.toString(),
            'commodity_id': commodityID.toString()
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



  Future<Map<String, dynamic>> updateInputDetail(int orderID, int commodityID, 
  int storeID, double quantity) async {
    
    try {
      final url = '${ApiConfig.apiUrl}/input/phone/create';

      final response = await http.put(
          url,
          body: {
            'order_id': orderID.toString(),
            'store_id': storeID.toString(),
            'commodity_id': commodityID.toString(),
            'quantity': quantity.toString()
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




  String parseDate(String dateString) {
    if(dateString != null) {
      DateTime parsedDate = DateTime.parse(dateString);
      final DateFormat format = DateFormat('dd/MM/yyyy');
      return format.format(parsedDate);  
    }

    return null;
  }
}