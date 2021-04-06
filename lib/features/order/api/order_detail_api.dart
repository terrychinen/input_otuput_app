import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:input_store_app/api_config.dart';
import 'package:input_store_app/features/order/models/order_detail/order_detail.dart';

class OrderDetailAPI {
     Future<Map<String, dynamic>> getOrderDetail(int purchaseOrderID) async {
    try {
      final url = '${ApiConfig.apiUrl}/purchase_order/${purchaseOrderID.toString()}?offset=0';

      final response = await http.get(url).timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];

      if(response.statusCode == 200) {
        final orderDetailResponse = parseResponse['result'] as List;
        List<OrderDetail> orderDetailList = List<OrderDetail>.from(orderDetailResponse.map((i) => OrderDetail.fromJson(i)));

        return {'ok': true, 'result': orderDetailList};
      }
      return {'ok': false, 'message': message.toString()};
    }on PlatformException catch(e) {
      return {'ok': false, 'message': e.toString()};
    } on TimeoutException catch(_) {
      return {'ok': false, 'message': 'No se ha establecido la conexión con el servidor'};  
    }
  }
}