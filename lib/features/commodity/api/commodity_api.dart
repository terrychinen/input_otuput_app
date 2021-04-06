import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:input_store_app/api_config.dart';
import 'package:input_store_app/features/commodity/models/commodity.dart';

class CommodityAPI {
  Future<Map<String, dynamic>> checkIfStoreAndCommodityExists(int storeID, 
  int commodityID) async {
      try {
        final url = '${ApiConfig.apiUrl}/store_commodity/phone/check/by'+
          '?store_id=${storeID.toString()}'+
          '&commodity_id=${commodityID.toString()}';

        final response = await http.get(url).timeout(Duration(seconds: 10));

        final parseResponse = jsonDecode(response.body);
        final message = parseResponse['message'];

        if(response.statusCode == 200){
          final commodityResponse = parseResponse['result'] as List;
          List<Commodity> commodityList = List<Commodity>.
            from(commodityResponse.map((i) => Commodity.fromJson(i)));

          return {'ok': true, 'result': commodityList};
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

  Future<Map<String, dynamic>> getCommodity(int storeID, 
  int commodityID) async {
    try {
      final url = '${ApiConfig.apiUrl}/store_commodity/phone/check/by?'+
        'store_id=${storeID.toString()}&'+
        'commodity_id=${commodityID.toString()}';
        
      final response = await http.get(url).timeout(Duration(seconds: 20));

      final parseResponse = jsonDecode(response.body);
      
      print(response.body);

      final message = parseResponse['message'];
      final commodityResponse = parseResponse['result'];  

      if(response.statusCode == 200){
         List<Commodity> commodityList = List<Commodity>
          .from(commodityResponse.map((i) => Commodity.fromJson(i)));

        return {'ok': true, 'result': commodityList, 'message': message};
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
}

   