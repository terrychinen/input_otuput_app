import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/features/auth/models/user.dart';
import 'package:input_store_app/user_storage.dart';
import 'package:input_store_app/widgets/alert_modal_widget.dart';
import 'package:input_store_app/widgets/loading_modal_widget.dart';
import 'package:input_store_app/features/commodity/models/commodity.dart';
import 'package:input_store_app/features/output/controllers/output_controller.dart';
import 'package:input_store_app/features/output/controllers/get_user_controller.dart';
import 'package:input_store_app/features/environment/models/models/environment.dart';
import 'package:intl/intl.dart';

class CreateOutputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController textController = new TextEditingController();

    OutputController outputController = Get.find();
    Commodity commodity = outputController.commodityList[0];

    return Scaffold(
      body: GetBuilder<GetUserController>(
        init: GetUserController(),
        builder: (_) => Obx(() {
          if(_.loading) {
            return Center(
              child: CircularProgressIndicator()
            );
          }

          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: 50,
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
                      'Salida', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                  top: 50, bottom: 20, right: 20, left: 20
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      Text(
                        commodity.commodityName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700
                        )
                      ),
                    
                      SizedBox(height: 40),

                      textWidget('ID del almacén: ', 
                        commodity.storeId.toString()),
                  
                      textWidget('Nombre del almacén: ', 
                        commodity.storeName),
                      
                      textWidget('ID de la mercancía: ', 
                        commodity.commodityId.toString()),
                      
                      textWidget('Nombre de la mercancía: ', 
                        commodity.commodityName),
                      
                      textWidget('Stock actual: ', 
                        commodity.stock.toString()),
                      
                      textWidget('Stock min: ', 
                        commodity.stockMin.toString()),

                      SizedBox(height: 30),

                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Ambiente: ', 
                              style: TextStyle(fontSize: 16)
                            ),
                          ]
                        )
                      ),

                      _DropDownEnvironmentWidget(),

                      SizedBox(height: 20),
                                          
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Text('Lote: ', style: TextStyle(fontSize: 16)),
                            SizedBox(width: 20),
                            Container(
                              width: screenWidth * 0.22,
                              height: 40,
                              margin: EdgeInsets.only(bottom: 20),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (query) {
                                  outputController.note = query;
                                }
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Cantidad que va a sacar: ', 
                        style: TextStyle(fontSize: 16)
                      ),

                      SizedBox(width: 20),
                
                      quantityField(outputController,
                          textController, screenWidth),

                      SizedBox(height: 40),

                      Row(
                        children: [
                          Text(
                            'Se lo entrega a: ',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start
                          ),
                          SizedBox(width: 20),
                          _DropDownUserWidget(),
                        ],
                      ),

                      SizedBox(height: 30),
                      

                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: 
                          MaterialStateProperty.all<Color>(Colors.black)),
                        child: Text('Guardar'),
                        onPressed: () async {                         
                            await outputController.createOutput(
                              commodity.storeId, commodity.commodityId, 
                              outputController.note,
                              outputController.addValue, 
                              UserStorage.user.userId, 
                              _.userSelected.userId, 
                              _.environmentSelected.environmentID);
                        }
                      )
                    ],
                  ),
                ),
              ),
              outputController.createLoading ? 
                ModalProgressWidget() : 
                Container(),
              
              outputController.isMessage ? 
                AlertModalWidget(                                
                  icon: outputController.icon,
                  iconColor: outputController.colorIcon,
                  title: outputController.title,
                  description: outputController.message,
                  descriptionColor: Colors.black,
                  buttonText: 'Aceptar',
                  colorButton: Colors.black,                  
                  buttonFunction: () async{
                    outputController.title = '';
                    outputController.message = '';                    
                    outputController.isMessage = false;
                    Navigator.of(context).pop();
                    final DateTime now = new DateTime.now();
                    final DateFormat format = DateFormat('yyyy-MM-dd');
                    await outputController.loadOutputs(format.format(now), 0, 1);
                  },
                ) : Container()
              ],
            );
          }
        ),
      )
    );
  }

  Widget quantityField(OutputController _, 
    TextEditingController textController, double screenWidth) {

    textController.text = _.addValue.toString();
    textController.selection = 
      TextSelection.fromPosition(
        TextPosition(offset: textController.text.length)
      );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [        
        Container(
          width: screenWidth * 0.2,
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Cant.'
            ),
            onSubmitted: (query) {
              double newValue = double.parse(query);
              if(newValue > _.commodityList[0].stock) {
                _.addValue = _.commodityList[0].stock;
              }else {
                _.addValue = newValue;
              }

              textController.text = _.addValue.toString();
            },
          ),
        ),

        SizedBox(width: 30),

         addOrMinusButton('+1', 1, _, textController, Colors.green),

        SizedBox(width: 10),

        addOrMinusButton('-1', -1, _, textController, Colors.red),
      ],
    );
  }


  Widget textWidget(String text1, String text2) {
    return Column(
      children: [
        Row(
          children: [
            Text(text1, style: TextStyle(fontSize: 15)),
            Expanded(
              child: Text(
                text2, 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold
                )
              )
            )
          ],
        ),
        SizedBox(height: 10)
      ],
    );
  }


  Widget addOrMinusButton(String description, double value, 
  OutputController _, TextEditingController textController, Color color) {
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



class _DropDownUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GetUserController _ = Get.find();

    return Obx(() => DropdownButton(
      value: _.userSelected,
      items: _.userList
        .map<DropdownMenuItem<User>>((User value) {
          return DropdownMenuItem<User>(
            value: value,
            child: Text(value.username)
          );
        }).toList(),
        onChanged: (User newValue) {
          _.userSelected = newValue;
        },
    ));
  }
}


class _DropDownEnvironmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GetUserController _ = Get.find();

    return Obx(() => DropdownButton(
      value: _.environmentSelected,
      items: _.environmentList
        .map<DropdownMenuItem<Environment>>((Environment value) {
          return DropdownMenuItem<Environment>(
            value: value,
            child: Text(value.name)
          );
        }).toList(),
        onChanged: (Environment newValue) {
          _.environmentSelected = newValue;
        },
    ));
  }
}