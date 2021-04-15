import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/features/output/models/output.dart';
import 'package:input_store_app/features/output/controllers/output_controller.dart';
import 'package:input_store_app/features/output/controllers/edit_output_controller.dart';

class EditOutputModalSheetWidget extends StatelessWidget {  
  @required final Output output;

  EditOutputModalSheetWidget({
    this.output
  });

  @override
  Widget build(BuildContext context) {
    final OutputController outputController = Get.find();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController textController = new TextEditingController();
    textController.selection = 
      TextSelection.fromPosition(
        TextPosition(offset: textController.text.length)
      );

    return GetBuilder<EditOutputController>(
      init: EditOutputController(),
      builder: (_) => Obx(() {
        _.output = this.output;
        textController.text = _.addValue.toString();
        return Container(
          height: screenHeight * 0.8,
          padding: EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  'DEVOLUCIÓN',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                ),

                SizedBox(height: 25),

                textWidget('Mercancía: ', this.output.commodityName),          
                SizedBox(height: 10),

                textWidget('Almacén: ', this.output.storeName),
                SizedBox(height: 10),

                textWidget('Lote: ', this.output.note),        
                SizedBox(height: 10),

                textWidget('Ha sacado: ', this.output.quantity.toString()),        
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
                            if(newValue >= 0) {
                              if(newValue < _.output.quantity) {
                                 _.editValue(newValue);
                              }                             
                            }else {
                              _.editValue(0);
                            }
                          },
                        ),
                      ),

                      SizedBox(width: 15),

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: addOrMinusButton('+1', 1, textController, Colors.green)
                    ),

                  SizedBox(width: 15),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: addOrMinusButton('-1', -1, textController, Colors.red)
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
                    
                  child: Text('DEVOLVER'),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                       builder: (__) => AlertDialog(
                         title: Text('Actualizar'),
                         content: Text(
                           '¿Desea devolver x${_.addValue} de ${output.commodityName}?',
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
                                final leftQuantity = output.quantity - _.addValue;
                                final updateStock = await _.updateStock(
                                  output.outputId, 
                                  output.storeId, 
                                  output.commodityId, 
                                  _.addValue,
                                  leftQuantity
                                );

                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (____) => AlertDialog(
                                    title: Text('Repuesta'),
                                    content: Text(
                                      updateStock['message'],
                                      style: TextStyle(fontSize: 16),
                                    ),

                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Ok', 
                                          style: TextStyle(color: Colors.black, fontSize: 17)
                                        ),
                                        
                                        onPressed: () {
                                          final DateFormat format = DateFormat('yyyy-MM-dd');
                                          final String dateFormat = format.format(outputController.datePicked);
                                          
                                          outputController.loading = true;
                                          outputController.loadOutputs(dateFormat, 0, 1);                                         
                                          outputController.loading = false;
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }                            
                                      ),
                                    ],
                                  )
                                );                               
                              }                            
                            ),
                          ]
                       )
                    );
                  }
                )
          ]
        ),
      ),
    );
      }),
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
  TextEditingController textController, Color color) {
    EditOutputController _ = Get.find();
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