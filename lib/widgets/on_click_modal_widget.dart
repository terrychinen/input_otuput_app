import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

  onAlertButtonsPressed({
    String title,
    String desc,
    double fontSizeDesc = 15.0,
    IconData icon,
    Color colorButtonAndIcon,
    Function function
  }){
    Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(color:  Color.fromRGBO(40, 40, 40, 1.0), borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 30.0,),
                          Icon(
                            icon, 
                            color: colorButtonAndIcon, 
                            size: 80.0
                          ),

                          SizedBox(height: 20.0,),
                          
                          Text(
                            title.toString(), 
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none
                              )
                            )
                          ),

                          SizedBox(height: 10.0,),

                          Text(
                            desc.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.white,                               
                                fontWeight: FontWeight.w400, 
                                fontSize: fontSizeDesc, 
                                decoration: TextDecoration.none
                              ),
                            )
                          ),

                          SizedBox(height: 30.0),
                          
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: 
                                MaterialStateProperty
                                  .all<Color>(colorButtonAndIcon)
                            ),
                            child: Text(
                              'Aceptar', 
                              style: TextStyle(color: Colors.white)
                            ),
                            onPressed: (){function();},
                          )
                        ],
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

