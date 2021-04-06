import 'package:flutter/material.dart';

class DateTextFieldWidget extends StatelessWidget {
  @required final DateTime datePicked;

  DateTextFieldWidget({
    this.datePicked
  });

  @override
  Widget build(BuildContext context) {    
    return Row(
      children: [
        Container(
          width: 130,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(3,4),
                blurRadius: 2
              )
            ]
          ),
          child: Center(
            child: Text(
              '${this.datePicked.day}/'+
              '${this.datePicked.month.toString().length > 1 
                  ? this.datePicked.month : '0'+( this.datePicked.month).toString()}/'+
              '${this.datePicked.year}', style: TextStyle(color: Colors.black),
            )
          )
        )
      ],
    );
  }
}