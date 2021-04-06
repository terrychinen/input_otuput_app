import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:input_store_app/api_config.dart';
import 'package:input_store_app/features/order/models/order/order.dart';

class OrderAPI {
     Future<Map<String, dynamic>> getOrders() async {
    try {
      final url = '${ApiConfig.apiUrl}/purchase_order/phone/search/bydate';

      final response = await http.get(url).timeout(Duration(seconds: 10));

      final parseResponse = jsonDecode(response.body);
      final message = parseResponse['message'];

      if(response.statusCode == 200){
        final orderResponse = parseResponse['result'] as List;
        List<Order> orderList = List<Order>.from(orderResponse.map((i) => Order.fromJson(i)));

        for(int i=0; i<orderList.length; i++) {
          Order order = orderList[i];
          order.orderDate = parseDate(order.orderDate);
          order.receiveDate = parseDate(order.receiveDate);
          order.paidDate = parseDate(order.paidDate);
          order.cancelDate = parseDate(order.cancelDate);
        }

        return {'ok': true, 'result': orderList};
      }
      return {'ok': false, 'message': message.toString()};
    }on PlatformException catch(e) {
      return {'ok': false, 'message': e.toString()};
    } on TimeoutException catch(_){
      return {'ok': false, 'message': 'No se ha establecido la conexión con el servidor'};  
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
}