import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/features/input/controllers/input_order_controller.dart';
import 'package:input_store_app/features/input/widgets/input_order_list_widget.dart';
import 'package:input_store_app/widgets/date_text_field_widget.dart';
import 'package:intl/intl.dart';

class InputOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Entrada por órden de pedido'),
      ),

      body: GetBuilder<InputOrderController>(
        init: InputOrderController(),
        builder: (_) => Obx(() {
          if(_.loading) return Center(child: CircularProgressIndicator());
          return Stack(
            children: [
              _.inputList.length == 0 ?
              Center(child: Text('No hay ninguna entrada con esta fecha',
                style: TextStyle(fontSize: 18.0))) :

              Container(
                margin: EdgeInsets.only(top: 90),
                child: InputOrderListWidget(
                  inputList: _.inputList,
                  crossAxisCount: 1
                )
              ),

              Positioned(
                top: 20,
                left: 10,
                child: Row(
                  children: [
                    Text('Fecha: ', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 10),
                    _DateWidget()
                  ],
                ),
              )
            ],
          );
        }),
      )
    );
  }
}

class _DateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InputOrderController _ = Get.find();
    return Obx(() => GestureDetector(
      onTap: () async {
        DateTime firstDate = new DateTime(2018, 01, 01);
        final isDate = await showDatePicker(
          context: context,
          initialDate: _.datePicked == null ? DateTime.now() : _.datePicked,
          firstDate: firstDate,
          lastDate: DateTime.now(),
          cancelText: 'CANCELAR',
          errorFormatText: 'Formato inválido',
          fieldLabelText: 'Ingrese la fecha',
          locale: Locale('es'),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark(),
              child: child
            );
          }
        );

        if(isDate != null) {
          _.datePicked = isDate; 
          final DateFormat format = DateFormat('yyyy-MM-dd');
          final String dateFormat = format.format(_.datePicked);

          await _.loadInputs(dateFormat);
        }
      },
      child: DateTextFieldWidget(datePicked: _.datePicked),
    ));
  }
}