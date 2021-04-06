import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:input_store_app/widgets/alert_modal_widget.dart';
import 'package:input_store_app/features/input/pages/input_page.dart';
import 'package:input_store_app/features/output/pages/output_page.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:input_store_app/features/home/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Obx(() => SafeArea(
        child: Stack(
          children: [
            Scaffold(
              bottomNavigationBar: SnakeNavigationBar.color(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                behaviour: SnakeBarBehaviour.pinned,
                elevation: 50.0,
                snakeViewColor: Colors.black,
                unselectedItemColor: Colors.black,
                currentIndex: _.currentIndex,
                onTap: (index) {
                  _.currentIndex = index;            
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.outdent), 
                    label: 'Salida'
                  ),
                  
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.truckLoading), 
                    label: 'Entrada'
                  ),
                ],
              ),
              body: _HomePageBody()
            ),

            Container(
              child: _.isError ? AlertModalWidget(
                icon: FontAwesomeIcons.times,
                iconColor: Colors.redAccent, 
                title: 'Error', 
                titleColor: Colors.black,
                descriptionColor: Colors.black,
                description: _.message,
                buttonText: 'Aceptar', 
                buttonFunction: () {
                  _.isError = false;
                  _.message = '';
                }
              ) : Container(),
            ),
          ],
        )
      )),
    );
  }
}


class _HomePageBody extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    final HomeController _ = Get.find();
    if (_.currentIndex == 0) {
      return OutputPage();
    }else 
      return InputPage();
  }
}