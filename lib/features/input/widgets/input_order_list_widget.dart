import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/features/input/models/input/input.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:input_store_app/features/input/controllers/input_controller.dart';
import 'package:input_store_app/features/order/models/order/order.dart';
import 'package:input_store_app/features/order/pages/edit_order_detail_page.dart';

class InputOrderListWidget extends StatelessWidget {
  @required final List<Input> inputList;
  @required final int crossAxisCount;

  InputOrderListWidget({
    this.inputList,
    this.crossAxisCount
  });

  @override
  Widget build(BuildContext context) {
    InputController _ = Get.find();

    return StaggeredGridView.countBuilder(
      crossAxisCount: this.crossAxisCount,
      physics: BouncingScrollPhysics(),
      itemCount: this.inputList.length,
      itemBuilder: (_, index) {
        Input input = this.inputList[index];    
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(            
            title: Text(
              '${input.providerName}',
              style: TextStyle(fontSize: 18.0)
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget('Fec. entrada: ', input.inputDate),
                SizedBox(height: 5),
                textWidget('Nota: ', input.note),
                SizedBox(height: 20),
              ]
            ),
            leading: Text(
              '${index + 1} -',
              style: TextStyle(fontSize: 18.0)
            ),
            onTap: () {
              Order order = new Order();
              order.purchaseOrderId = input.purchaseOrderId;
              order.providerId = input.providerId;
              order.providerName = input.providerName;
              order.employeeId = input.employeeId;
              order.employeeName = input.employeeName;
              order.orderDate = input.orderDate;
              order.receiveDate = input.receiveDate;
              order.totalPrice = input.totalPrice;
              order.note = input.note;

              Navigator.push(context, MaterialPageRoute(builder: (__) {
                return EditOrderDetailPage(order: order);
              }));
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
         Text(
          text2,
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold
          )
        )
      ],
    );
  }
}