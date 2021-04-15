import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/widgets/loading_widget.dart';
import 'package:input_store_app/widgets/alert_modal_widget.dart';
import 'package:input_store_app/features/order/models/order/order.dart';
import 'package:input_store_app/features/order/widgets/card_order_detail_widget.dart';
import 'package:input_store_app/features/order/widgets/edit_order_detail_list_widget.dart';
import 'package:input_store_app/features/order/controllers/order_detail_error_controller.dart';

class EditOrderDetailPage extends StatelessWidget {
  @required final Order order;

  EditOrderDetailPage({
    this.order
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<OrderDetailErrorController>(
      init: OrderDetailErrorController(),
      builder: (_) => Stack(
        children: [
          _.isLoading ? LoadingWidget() : Container(),
          Scaffold(
            appBar: AppBar(
              title: Text('${this.order.providerName}'),
              backgroundColor: Colors.black,
            ),
          
            body: Stack(
              children: [
                Column(
                  children: [
                    CardOrderDetailWidget(order: this.order),
                    Card(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 80,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Nota: ${order.note == null || order.note == '' ? '-' : order.note}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 250, bottom: 70),
                  child: EditOrderDetailListWidget(
                    order: this.order,
                    crossAxisCount: 1
                  ),
                ),
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
          ) : Container()),

          Obx(() => _.isEnd ? AlertModalWidget(
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
              _.isEnd = false;

              Navigator.pop(context);
            }
          ) : Container())
        ]
      )
    );
  }
}