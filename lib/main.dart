import 'package:flutter/material.dart';
import 'package:multi_store_app/authentication/customer_login.dart';
import 'package:multi_store_app/authentication/customer_signup.dart';
import 'package:multi_store_app/authentication/service_login.dart';
import 'package:multi_store_app/authentication/service_signup.dart';
import 'package:multi_store_app/main_screen/customer_home.dart';
import 'package:multi_store_app/main_screen/welcom_screen.dart';
import 'package:multi_store_app/provider/wishlist_provider.dart';
import 'package:multi_store_app/authentication/supplier_login.dart';
import 'package:multi_store_app/authentication/supplier_signup.dart';
import 'package:provider/provider.dart';
import 'main_screen/supplier_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'provider/cart_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'provider/stripe_id.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
     ChangeNotifierProvider (create: (_) => Cart()),
      ChangeNotifierProvider (create: (_) => Wish())
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/welcom_screen',
        routes: {
          '/welcom_screen': (context) => const WelcomScreen(),
          '/customer_home': (context) => const CustomerHomeScreen(),
          '/supplier_home': (context) => const SupplierHomeScreen(),
          '/customer_signup': (context) => const CustomerRegister(),
          '/customer_login': (context) => const CustomerLogin(),
          '/supplier_signup': (context) => const SupplierRegister(),
          '/supplier_login': (context) => const SupplierLogin(),
          '/service_login': (context) => const ServiceLogin(),
          '/service_signup': (context) => const ServiceRegister(),

          

        });
  }
}
