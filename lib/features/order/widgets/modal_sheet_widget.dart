import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/features/order/controllers/order_detail_error_controller.dart';
import 'package:input_store_app/features/order/models/order_detail/order_detail.dart';
import 'package:input_store_app/features/order/controllers/order_detail_controller.dart';

class ModalSheetWidget extends StatelessWidget {
  @required final int index;
  @required final OrderDetail orderDetail;

  ModalSheetWidget({
    this.index,
    this.orderDetail,
  });

  @override
  Widget build(BuildContext context) {
    final OrderDetailController _ = Get.find();
    final OrderDetailErrorController orderErrorController = Get.find();

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController textController = new TextEditingController();
    textController.text = _.addValue.toString();
    textController.selection = 
      TextSelection.fromPosition(
        TextPosition(offset: textController.text.length)
      );

    return Container(
      height: screenHeight * 0.7,
      padding: EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              orderDetail.commodityName.toUpperCase(), 
              style: TextStyle(fontSize: 22)
            ),

            SizedBox(height: 25),

            textWidget(
              'Se almacenará como: ',
              _.commoditySelected.commodityName
            ),
            
            SizedBox(height: 10),

            textWidget(
              'Almacén: ', 
              _.commoditySelected.storeName
            ),

            SizedBox(height: 10),

            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      'Cantidad: ',
                      style: TextStyle(fontSize: 16)
                    ),
                  ),

                  SizedBox(width: 15),

                  Container(
                    width: screenWidth * 0.2,
                    height: 40,
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: textController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (query) {
                        double newValue = double.parse(query);
                        if(newValue != 0) {
                          _.editValue(newValue);
                        }else {
                          _.editValue(1.0);
                        }                        
                      },
                    ),
                  ),

                  SizedBox(width: 15),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: addOrMinusButton(
                      '+1', 1, _, textController,
                      Colors.green
                    )
                  ),

                  SizedBox(width: 15),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: addOrMinusButton(
                      '-1', -1, _, textController,
                      Colors.red
                    )
                  )

                ]
              )
            ),

            SizedBox(height: 50),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.
                  all<Color>(Colors.black)
              ),
                
              child: Text('Guardar'),
              onPressed: () async {
                _.addCommodity(index);

                final createInputDetail = await _.createInputDetail(
                  orderDetail.purchaseOrderId,
                  _.commoditySelected.storeId,
                  _.commoditySelected.commodityId,
                  _.commoditySelected.stock
                );

                if(createInputDetail['ok']) {
                  orderErrorController.icon = FontAwesomeIcons.checkCircle;
                  orderErrorController.iconColor = Colors.green;
                  orderErrorController.title = 'Éxito';
                }else {
                  orderErrorController.icon = FontAwesomeIcons.exclamationCircle;
                  orderErrorController.iconColor = Colors.red;
                  orderErrorController.title = 'Error';
                }

                
                orderErrorController.description = createInputDetail['message'];
                orderErrorController.isError = true;

                Navigator.of(context).pop();                
              }
            )

          ]
        ),
      ),
    );
  }


  Widget textWidget(String description, String value) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            description,
            style: TextStyle(fontSize: 16)
          ),
                
          SizedBox(width: 5),
                
          Expanded(
            child: Text(
              value, 
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold
              )
            ),
          )
        ]
      ),
    );
  }


  Widget addOrMinusButton(String description, double value, 
  OrderDetailController _, TextEditingController textController, Color color) {
    return Container(
      width: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color)
        ),
        child: Text(description),
        onPressed: () {
          _.returnValue(value);
          textController.text = _.addValue.toString();
        }
      ),
    );
  }
}