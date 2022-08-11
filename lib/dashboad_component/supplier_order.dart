import 'package:flutter/material.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';

import 'delivered_order.dart';
import 'preparin_order.dart';
import 'shipping_oreder.dart';

class SupplierOrders extends StatelessWidget {
  const SupplierOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
           elevation: 0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton() ,
            title: const  AppBarTitle(
               title: 'Orders'), 
               bottom: const TabBar(
                indicatorColor: Color.fromARGB(255, 33, 212, 243),
                indicatorWeight: 8,
                tabs: [
                RepeatedTab(label: 'Preparing'),
                RepeatedTab(label: 'Shipping'),
                RepeatedTab(label: 'Delivered'),
               ]),
            ),
            body: const TabBarView(children: [
              Preparing(),
              Shipping(),
              Delivered(),
            ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.grey,
        ),
      ),
    ));
    
  }
}