import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:input_store_app/widgets/date_text_field_widget.dart';
import 'package:input_store_app/features/input/controllers/input_controller.dart';
import 'package:input_store_app/features/input/widgets/input_detail_list_widget.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputController>(
      init: InputController(),
      builder: (_) => Obx(() {
        if(_.loading) return Center(child: CircularProgressIndicator());
        return Stack(
          children: [
              _.inputDetailList.length == 0 ?
                Center(child: Text('No hay ninguna entrada con esta fecha',           
                  style: TextStyle(fontSize: 18.0))) :
            Container(
              margin: EdgeInsets.only(top: 150),           
              child: InputDetailListWidget(
                inputDetailList: _.inputDetailList, 
                crossAxisCount: 1
              )
            ),

            Positioned(
              top: 20,
              left: 10,
              child: Text(
                'ENTRADA', 
                style: TextStyle(
                  fontSize: 40, 
                  fontWeight: FontWeight.w700
                )
              ),
            ),

            Positioned(
              top: 20,
              right: 15,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow> [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(4, 5),
                      blurRadius: 15
                    )
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.plus, 
                    color: Colors.white
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/order');
                  },
                )
              )
            ),

            Positioned(
              top: 100,
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
      })
    );
  }
}


class _DateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InputController _ = Get.find();
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

          await _.loadInputDetails(dateFormat);
        }
      },
      child: DateTextFieldWidget(datePicked: _.datePicked),
    ));
  }
}