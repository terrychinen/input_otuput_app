import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/widgets/loading_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:input_store_app/widgets/alert_modal_widget.dart';
import 'package:input_store_app/features/order/models/order/order.dart';
import 'package:input_store_app/features/order/controllers/order_controller.dart';
import 'package:input_store_app/features/order/widgets/card_order_detail_widget.dart';
import 'package:input_store_app/features/order/widgets/order_detail_list_widget.dart';
import 'package:input_store_app/features/order/controllers/order_detail_error_controller.dart';

class OrderDetailPage extends StatelessWidget {
  @required final Order order;

  OrderDetailPage({
    this.order
  });

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
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
                        height: 100,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        padding: EdgeInsets.only(top: 5),
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(                            
                            hintText: 'Nota',
                            labelText: 'Nota',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          onChanged: (query) {
                            if(query == '' || query == null) {
                              _.note = '';
                            }else {
                              _.note = query;
                            }                            
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 250, bottom: 70),
                  child: OrderDetailListWidget(
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
                      child: Text('FINALIZAR', style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        showDialog(
                          context: context, 
                          barrierDismissible: false,
                          builder: (__) => AlertDialog(
                            title: Text('Confirmar'),
                            content: Text(
                              '¿Ya ingresó todas las mercancías?',                              
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  'No', 
                                  style: TextStyle(color: Colors.black, fontSize: 17)
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }                            
                              ),

                               TextButton(
                                child: Text(
                                  'Sí', 
                                  style: TextStyle(color: Colors.black, fontSize: 17)
                                ),
                                onPressed: () async {
                                  final updateInput = await _.updateInput(this.order.purchaseOrderId, _.note);
                                  if(updateInput['ok']) {
                                    _.icon = FontAwesomeIcons.checkCircle;
                                    _.iconColor = Colors.green;
                                    _.title = 'Éxito';
                                  }else {
                                    _.icon = FontAwesomeIcons.exclamationCircle;
                                    _.iconColor = Colors.red;
                                    _.title = 'Error';
                                  }

                                  _.description = updateInput['message'];
                                  _.isEnd = true;
                                  orderController.loading = true;
                                  orderController.loadOrders();
                                  orderController.loading = false;
                                  Navigator.pop(context);
                                }                            
                              ),
                            ],

                          )
                        );                       
                      },
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