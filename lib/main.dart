import 'package:flutter/material.dart';
import 'package:multi_store_app/authentication/customer_login.dart';
import 'package:multi_store_app/authentication/customer_signup.dart';
import 'package:multi_store_app/main_screen/customer_home.dart';
import 'package:multi_store_app/main_screen/welcom_screen.dart';
import 'package:multi_store_app/supplier_login.dart';
import 'package:multi_store_app/supplier_signup.dart';
import 'main_screen/supplier_home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          '/supplier_home': (context) => const SupplierHomeScreen(),
          '/customer_signup': (context) => const CustomerRegister(),
          '/customer_login': (context) => const CustomerLogin(),
          '/supplier_signup': (context) => const SupplierRegister(),
          '/supplier_login': (context) => const SupplierLogin(),
          

        });
  }
}
