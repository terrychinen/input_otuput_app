import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:input_store_app/features/auth/pages/auth_page.dart';
import 'package:input_store_app/features/home/pages/home_page.dart';
import 'package:input_store_app/features/input/pages/input_order_page.dart';
import 'package:input_store_app/features/input/pages/input_page.dart';
import 'package:input_store_app/features/order/pages/order_detail_page.dart';
import 'package:input_store_app/features/order/pages/order_page.dart';
import 'package:input_store_app/features/output/pages/create_output_page.dart';
import 'package:input_store_app/features/output/pages/output_page.dart';
import 'package:input_store_app/features/commodity/pages/commodity_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);      
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Input Store',
      initialRoute: '/auth',      
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routes: {
        '/auth': (_) => AuthPage(),
        '/home': (_) => HomePage(),
        '/input': (_) => InputPage(),
        '/output': (_) => OutputPage(),
        '/commodity': (_) => CommodityPage(),
        '/create_output': (_) => CreateOutputPage(),
        '/order': (_) => OrderPage(),
        '/order_detail': (_) => OrderDetailPage(),
        '/input_order': (_) => InputOrderPage()
      },
    );
  }
}