import 'package:flutter/material.dart';
import 'package:input_store_app/features/order/models/order/order.dart';

class CardOrderDetailWidget extends StatelessWidget {
  @required final Order order;

  CardOrderDetailWidget({
    this.order
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget('Fec. creado: ', order.orderDate),
            SizedBox(height: 5),

            textWidget('Fec. recibido: ', order.receiveDate),
            SizedBox(height: 5),

            textWidget(
              'Nota: ', 
              order.note == null || order.note == '' ? '-' : order.note
            ),
            SizedBox(height: 5),

            textWidget('Costo total: ', 'S/.${order.totalPrice.toString()}')
          ],
        ),
      ),
    );
  }

  Widget textWidget(String text1, String text2) {
    return Row(
      children: [
        Text(text1),
        Text(
          text2, 
          style: TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
      ],
    );
  }
}