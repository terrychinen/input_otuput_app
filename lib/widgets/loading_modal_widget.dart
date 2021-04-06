import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ModalProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: AlertDialog(insetPadding: EdgeInsets.all(0), backgroundColor: Colors.black.withOpacity(0.8), content: bodyProgress)
    );
  }

  final Widget bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            //color: Colors.grey,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: Get.width,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "Cargando...",
                      style: new TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

}
