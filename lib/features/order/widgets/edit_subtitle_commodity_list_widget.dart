import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:input_store_app/features/order/controllers/edit_order_detail_controller.dart';
import 'package:input_store_app/features/order/controllers/order_detail_error_controller.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:input_store_app/features/commodity/models/commodity.dart';

class EditSubTitleCommodityListWidget extends StatelessWidget {
  @required final int index;
  @required final List<Commodity> commodityList;

  EditSubTitleCommodityListWidget({
    this.index,
    this.commodityList
  });

  @override
  Widget build(BuildContext context) {
    final EditOrderDetailController _ = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: commodityList == null 
            || commodityList.length == 0 ? 0
            : commodityList.length,
            itemBuilder: (__, i) {
              Commodity commodity = commodityList[i];
                
              return Row(
                children: [
                  textWidget(commodity.commodityName, 2, false),
                  
                  SizedBox(width: 5),

                  textWidget(commodity.storeName, 2, false),

                  SizedBox(width: 10),

                  textWidget('X${commodity.stock}', 2, true),

                  ElevatedButton(
                    child: Icon(Icons.edit),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty
                        .all<Color>(Colors.orange)
                    ),
                    onPressed: () {
                      _.addValue = commodity.stock;
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => _ModalSheetWidget(
                          indexOriginal: index,
                          indexConvert: i,
                          commodity: commodity
                        )
                      );
                    }                    
                  ),

                  SizedBox(width: 20),
                ],
              );
            }
          )
        )
      ],
    );
  }

  Widget textWidget(String text, int flex, bool bold) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal
        )
      ),
    );
  }

}


class _ModalSheetWidget extends StatelessWidget {
  @required final int indexOriginal;
  @required final int indexConvert;
  @required final Commodity commodity;

  _ModalSheetWidget({
    this.indexOriginal,
    this.indexConvert,
    this.commodity
  });

  @override
  Widget build(BuildContext context) {
    final OrderDetailErrorController orderErrorController = Get.find();
    final EditOrderDetailController _ = Get.find();
    final screenHeight = MediaQuery.of(context).size.height;
    final textController = new TextEditingController();


    textController.text = _.addValue.toString();

    textController.selection = 
      TextSelection.fromPosition(
        TextPosition(offset: textController.text.length)
    );

    return Container (
      height: screenHeight * 0.7,
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Text(
                commodity.commodityName, 
                style: TextStyle(fontSize: 25)
              ),
            ),

            SizedBox(height: 30),

            Row(
              children: [
                Text('Almacén: ', style: TextStyle(fontSize: 17)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    commodity.storeName, 
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    )
                  ),
                )
              ]
            ),

            SizedBox(height: 20),

            _QuantityWidget(textController: textController),

            SizedBox(height: 50),

            Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(              
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.
                        all<Color>(Colors.orange)
                    ),
                      
                    child: Text('Modificar', style: TextStyle(color: Colors.black)),
                    onPressed: () async {
                      await _.editCommodity(indexOriginal, indexConvert);

                      orderErrorController.icon = FontAwesomeIcons.checkCircle;
                      orderErrorController.iconColor = Colors.green;
                      orderErrorController.title = 'Éxito';
                      orderErrorController.description = 'Se actualizó correctamente';
                      orderErrorController.isError = true;

                      Navigator.of(context).pop();
                    }
                  ),

                   SizedBox(width: 20),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.
                        all<Color>(Colors.red)
                    ),
                      
                    child: Text('Eliminar'),
                    onPressed: () async {
                     showDialog(
                       context: context,
                       barrierDismissible: false,                       
                       builder: (__) => AlertDialog(
                         title: Text('Advertencia'),
                         content: Text(
                           '¿Desea descartar la entra de la '+
                            'mercancía ${commodity.commodityName}?',
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
                                final deleteInput = await _.deleteCommodityOrderDetail(
                                  indexOriginal, 
                                  indexConvert
                                );

                                if(deleteInput['ok']) {
                                  orderErrorController.icon = FontAwesomeIcons.checkCircle;
                                  orderErrorController.iconColor = Colors.green;
                                  orderErrorController.title = 'Éxito';
                                  orderErrorController.description = 'Se eliminó correctamente de la base de datos';
                                  orderErrorController.isError = true;
                                }

                                Navigator.of(context).pop();
                                Navigator.of(context).pop();                             
                              }                            
                            )
                          ],
                       )
                      );                      
                    }
                  ),
                ],
              ),
            )
          ]
        )
      )
    );
  }
}


class _QuantityWidget extends StatelessWidget {
  @required final TextEditingController textController;

  _QuantityWidget({
    this.textController
  });

  @override
  Widget build(BuildContext context) {
    final EditOrderDetailController _ = Get.find();
    final screenWidth = MediaQuery.of(context).size.width;        

    return Container(
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
              }
            ),
          ),
          
          SizedBox(width: 15),
          
          addOrMinusButton('+1', 1, Colors.green, textController),
          
          SizedBox(width: 15),
          
          addOrMinusButton('-1', -1, Colors.red, textController)
          
        ]
      )
    );
  }

  Widget addOrMinusButton(String description, double value, Color color,
  TextEditingController textController) {
    EditOrderDetailController _ = Get.find();

    return Container(
      width: 50,
      margin: EdgeInsets.only(top: 10),
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