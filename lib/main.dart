import 'package:flutter/material.dart';
import 'package:multi_store_app/authentication/customer_signup.dart';
import 'package:multi_store_app/main_screen/customer_home.dart';
import 'package:multi_store_app/main_screen/welcom_screen.dart';

import 'main_screen/supplier_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: WelcomScreen(),
        initialRoute: '/welcom_screen',
        routes: {
          '/welcom_screen': (context) => const WelcomScreen(),
          '/customer_home': (context) => const CustomerHomeScreen(),
          '/supplier—home': (context) => const SupplierHomeScreen(),
          '/customer_signup': (context) => const CustomerRegister(),
        });
  }
}
