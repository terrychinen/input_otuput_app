import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertModalWidget extends StatelessWidget {
  @required final IconData icon;
  final Color iconColor;
  @required final String title;
  final Color titleColor;
  @required final String description;
  final Color descriptionColor;
  @required final String buttonText;
  final Color colorButton;
  final Color textColorButton;
  @required final Function buttonFunction;

  AlertModalWidget({
    this.icon,
    this.iconColor = Colors.white,
    this.title,
    this.description,
    this.titleColor = Colors.black,
    this.descriptionColor = Colors.black,
    this.buttonText,
    this.colorButton = Colors.black,
    this.textColorButton = Colors.white,
    this.buttonFunction
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sizeWidth = screenSize.width;
    final sizeHeight = screenSize.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          width: sizeWidth * 0.85,
          height: sizeHeight * 0.45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow> [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(4, 6),
                blurRadius: 6
              )
            ]
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(this.icon, size: 80, color: this.iconColor),
                  Text(
                    this.title, 
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                      fontSize: 26, 
                      color: this.titleColor,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,                       
                    ))
                  ),
                  SizedBox(height: 10),
                  Text(
                    this.description, 
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: this.descriptionColor,
                      ),
                    ),
                    textAlign: TextAlign.center,                    
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text(
                      this.buttonText, style: 
                      TextStyle(color: this.textColorButton)
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        this.colorButton)
                    ),
                    onPressed: this.buttonFunction
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}