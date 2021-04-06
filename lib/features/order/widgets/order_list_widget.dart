import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/features/order/models/order/order.dart';
import 'package:input_store_app/features/order/pages/order_detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:input_store_app/features/input/controllers/input_controller.dart';
import 'package:input_store_app/user_storage.dart';

class OrderListwidget extends StatelessWidget {
  @required final List<Order> orderList;
  @required final int crossAxisCount;

  OrderListwidget({
    this.orderList,
    this.crossAxisCount
  });

  @override
  Widget build(BuildContext context) {
    final InputController inputController = Get.find();
    
    return StaggeredGridView.countBuilder(
      crossAxisCount: this.crossAxisCount,
      physics: BouncingScrollPhysics(),
      itemCount: this.orderList.length,
      itemBuilder: (_, index) {
        Order order = this.orderList[index];
        return Card(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListTile(
            title: Text(
              '${order.providerName}',
              style: TextStyle(fontSize: 18.0)
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget('Fec. creado: ', order.orderDate),
                textWidget('Fec. recibido: ', order.receiveDate),
              ]
            ),
            leading: Text(
              '${order.purchaseOrderId} -',
              style: TextStyle(fontSize: 18.0)
            ),
            onTap: () async {
              await inputController.searchInput(order.purchaseOrderId);

              if(inputController.input.length == 0) {
                await inputController.createInput(
                  order.purchaseOrderId, 
                  UserStorage.user.userId
                );

                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => OrderDetailPage(check: 0, order: order)
                ));
              }else {
                Navigator.push(context, MaterialPageRoute(
                builder: (_) => OrderDetailPage(check: 1, order: order)
              ));
              }
            }
          ),
        );
      },    
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,  
    );
  }

   Widget textWidget(String text1, String text2) {
    return Row(
      children: [
         Text(text1),
         Expanded(
           child: Text(
             text2, 
             style: TextStyle(
               color: Colors.black, 
               fontWeight: FontWeight.bold
              )
            )
          )
      ],
    );
  }
}