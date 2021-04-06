import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/widgets/alert_modal_widget.dart';
import 'package:input_store_app/features/order/models/order/order.dart';
import 'package:input_store_app/features/order/widgets/card_order_detail_widget.dart';
import 'package:input_store_app/features/order/widgets/order_detail_list_widget.dart';
import 'package:input_store_app/features/order/controllers/order_detail_error_controller.dart';

class OrderDetailPage extends StatelessWidget {
  @required final int check;
  @required final Order order;

  OrderDetailPage({
    this.check,
    this.order
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<OrderDetailErrorController>(
      init: OrderDetailErrorController(),
      builder: (_) => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('${this.order.providerName}'),
              backgroundColor: Colors.black,
            ),
          
            body: Stack(
              children: [
                Column(
                  children: [
                    CardOrderDetailWidget(order: this.order)
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 150, bottom: 70),
                  child: OrderDetailListWidget(
                    check: this.check,
                    order: this.order, 
                    crossAxisCount: 1
                  ),
                ),

                Positioned(
                  bottom: 0,                  
                  child: Container(
                    width: screenWidth,
                    height: 70,
                    margin: EdgeInsets.all(0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.
                          all<Color>(Colors.green)
                      ),
                      child: Text('CREAR', style: TextStyle(fontSize: 18)),
                      onPressed: () {},
                    ),
                  ),
                )

              ]
            )
          ),

          Obx(() => _.isError ? AlertModalWidget(                                
            icon: _.icon,
            iconColor: _.iconColor,
            title: _.title,
            description: _.description,
            descriptionColor: Colors.black,
            buttonText: 'Aceptar',
            colorButton: Colors.black,
            buttonFunction: () async{
              _.title = '';
              _.description = '';
              _.isError = false;             
            }
          ) : Container())
        ]
      )
    );
  }
}