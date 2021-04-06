import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/features/order/widgets/order_list_widget.dart';
import 'package:input_store_app/features/order/controllers/order_controller.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<OrderController>(
        init: OrderController(),
        builder: (_) => Obx(() {
          if(_.loading) {
            return Center(
              child: CircularProgressIndicator()
            );
          }

          return Stack(
            children: [
              _AppBarWidget(),

              Positioned(
                left: 10,
                top: 80,
                width: screenWidth * 0.95,
                height: 150,
                child: Container(
                  height: 150,
                  child: Text(
                    'Seleccione un pedido para ingresarlo al almacén:', 
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              
              _.orderList.length == 0 ?
              Center(
                child: Text(
                  'No hay ninguna salida con esta fecha',
                  style: TextStyle(fontSize: 18.0)
                )
              ) :
              
              Container(
                margin: EdgeInsets.only(top: 150),           
                child: OrderListwidget(
                  orderList: _.orderList,
                  crossAxisCount: 1
                )
              ),
            ],
          );
        }),
      )
    );
  }
}


class _AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Colors.black,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),

          Text(
            'Órden de pedidos recibidos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
            )
          ),
        ],
      ),
    );
  }
}