import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:input_store_app/widgets/loading_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:input_store_app/widgets/alert_modal_widget.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:input_store_app/features/auth/widgets/floating_widget.dart';
import 'package:input_store_app/features/auth/controllers/auth_controller.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {        
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (_) => Obx(() => Scaffold(
        floatingActionButton: FloatingWidget(_),
        body: Stack(
          children: [
            LoginBody(_),
            _.isLoading ? LoadingWidget() : Container(),
            _.isError ? AlertModalWidget(
              icon: FontAwesomeIcons.times,
              iconColor: Colors.redAccent,
              title: 'Error',
              description: _.message,
              buttonText: 'Aceptar',
              buttonFunction: () {
                _.isError = false;
              }
            ) : Container()
          ],
        )
      )
    ));
  }
}


class LoginBody extends StatelessWidget {
  @required final AuthController _;

  LoginBody(
    this._,
  );
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sizeWidth = screenSize.width;
    final sizeHeight = screenSize.height;

    return Scaffold(        
        body: Center(
          child: VisibilityDetector(
            onVisibilityChanged: (VisibilityInfo info) {
              _.visible = info.visibleFraction > 0;
          },
          key: Key('visible-detector-key'),
          child: BarcodeKeyboardListener(
            onBarcodeScanned: (barcode) {
              if (!_.visible) return;
              _.barcode = barcode;
            },
            child: Container(
              width: sizeWidth * 0.8,
              height: sizeHeight * 0.6,        
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow> [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(4, 5),
                    blurRadius: 5
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('SCANEANDO',
                    style: TextStyle(color: Colors.black, fontSize: 22.0)
                  ),
                  SizedBox(height: 10),
                  SpinKitThreeBounce(
                    color: Colors.black,
                    size: 20.0,
                  ),

                  SizedBox(height: 30),

                  Container(
                    width: sizeWidth * 0.7,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(        
                      cursorColor: Colors.black,                                   
                      decoration: InputDecoration(                      
                        hintText: 'usuario',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (query) {
                        this._.username = query;
                      },
                    ),
                  ),

                  SizedBox(height: 15),

                  Container(
                    width: sizeWidth * 0.7,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      cursorColor: Colors.black,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'clave',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (query) {
                        this._.password = query;
                      },
                    ),
                  ),

                  SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
                      ),
                      onPressed: () async {
                        this._.isLoading = true;
                        String username = this._.username;
                        String password = this._.password; 
                        var login = await this._.logIn(username, password);

                        this._.isLoading = false;
                        if(login['ok']) {
                          Navigator.pushNamed(context, '/home');
                        }else {
                          this._.isError = true;
                        }
                      },
                      child: Center(child: Text('Ingresar'))),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}