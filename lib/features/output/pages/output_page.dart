import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/widgets/date_text_field_widget.dart';
import 'package:input_store_app/features/output/widgets/output_list_widget.dart';
import 'package:input_store_app/features/output/controllers/output_controller.dart';
import 'package:input_store_app/features/output/widgets/output_floating_widget.dart';

class OutputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutputController>(
      init: OutputController(),
      builder: (_) => Obx(() {
        if(_.loading) return Center(child: CircularProgressIndicator());
        return Stack(
        children: [          
          _.outputList.length == 0 ?
            Center(
              child: Text(
                'No hay ninguna salida con esta fecha',           
                style: TextStyle(fontSize: 18.0)
              )
            ) :
          
            Container(
              margin: EdgeInsets.only(top: 150),           
              child: OutputListWidget(
                outputList: _.outputList, 
                crossAxisCount: 1
              )
            ),

            Positioned(
              top: 20,
              left: 10,
              child: Text(
                'SALIDA', 
                style: TextStyle(
                  fontSize: 40, 
                  fontWeight: FontWeight.w700
                )
              )
            ),

            Positioned(
              top: 20,
              right: 15,
              child: OutputFloatingWidget()
            ),

            Positioned(
              top: 100,
              left: 10,
              child: Row(
                children: [
                  Text('Fecha: ', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Obx(() {
                    if(_.loading) return Container();
                    return _DateWidget();
                  })
                ],
              ),
            ),
          ],
        );
      })
    );
  }      
}


class _DateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OutputController _ = Get.find();
    return GestureDetector(
      onTap: () async {
        DateTime firstDate = new DateTime(2018, 01, 01);
        final isDate = await showDatePicker(
          context: context,
          initialDate: _.datePicked == null 
            ? DateTime.now() : _.datePicked,
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

          await _.loadOutputs(dateFormat, 0, 1);
        }
      },
      child: Obx(() => DateTextFieldWidget(datePicked: _.datePicked)),
    );
  } 
}