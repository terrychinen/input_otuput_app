import 'package:flutter/material.dart';

class CommodityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 10,
          child: Text('MERCANCÍA', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700)),
        )
      ],
    );
  }
}