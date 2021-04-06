import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:input_store_app/features/auth/controllers/auth_controller.dart';

class FloatingWidget extends StatelessWidget {
  @required final AuthController authController;

  FloatingWidget(
    this.authController
  );

  @override
  Widget build(BuildContext context) {
    return authController.isLoading || authController.isError 
      ? isLoading(context) : isNotLoading(context);
  }

  Widget isNotLoading(BuildContext context) {
     return FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.qr_code_scanner),
        onPressed: () async {
          String barcodeScanRes = 
            await FlutterBarcodeScanner
              .scanBarcode('#FFFFFF', 'Cancelar', false, ScanMode.QR);

          if(barcodeScanRes != '-1') {
            authController.isLoading = true;
            var parseLogIn = jsonDecode(barcodeScanRes);

            String username = parseLogIn['username'];
            String password = parseLogIn['password'];

            if(username != null && password != null) {
              var logIn = await 
                authController.logIn(username, password);
              
              if(logIn['ok']) {
                Navigator.pushNamed(context, '/home');            
              }else {
                authController.isError = true;
              }
            }else {
              authController.message = 'El QR no contiene ' +
                'el parámetro "username" o "passowrd"';
              authController.isError = true;
            }

            authController.isLoading = false;                       
          }
      }
    );
  }



  Widget isLoading(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black.withOpacity(0.5),
      child: Icon(Icons.qr_code_scanner),
      onPressed: null
    );
  }


}