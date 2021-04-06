import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:input_store_app/features/home/controllers/home_controller.dart';
import 'package:input_store_app/features/output/controllers/output_controller.dart';

class OutputFloatingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find(); 
    OutputController outputController = Get.find();

    return Container(
      width: 50,
      height: 50,              
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 5),
            blurRadius: 10
          )
        ]
      ),
      
      child: IconButton(
        iconSize: 30,              
        icon: Icon(Icons.qr_code, color: Colors.white),
        onPressed: () async {
          String barcodeScanRes = 
            await FlutterBarcodeScanner.scanBarcode(
              '#FFFFFF', 'Cancelar', false, ScanMode.QR
            );

          if(barcodeScanRes != '-1') {
            var parseOutput = jsonDecode(barcodeScanRes);

            int storeID = parseOutput['store_id'];
            int commodityID = parseOutput['commodity_id'];

            if(storeID != null && commodityID != null) {
              await outputController.checkIfStoreAndCommodityExist(storeID, commodityID);
              if(outputController.commodityList.length > 0) {                
                Navigator.pushNamed(context, '/create_output');
              }else {
                homeController.message = 'La asociasión de la mercancía con almacén no existe';
                homeController.isError = true;
              }              
            }else {
              homeController.message = 'El QR no es sobre mercancía o no tiene un formato correcto';
              homeController.isError = true;
            }
          }
        }
      )
    );
  }
}