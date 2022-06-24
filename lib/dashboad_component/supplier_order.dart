import 'package:flutter/material.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';

class SupplierOrders extends StatelessWidget {
  const SupplierOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
        backgroundColor: Colors.white,
          title: const  AppBarTitle( title: 'Supplier Orders'), 
          leading: const AppBarBackButton() ,),
    );
  }
}
