import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboad_component/edit_business.dart';
import 'package:multi_store_app/dashboad_component/manage_product.dart';
import 'package:multi_store_app/dashboad_component/sup_statics.dart';
import 'package:multi_store_app/dashboad_component/supplier_balance.dart';
import 'package:multi_store_app/dashboad_component/supplier_order.dart';
import 'package:multi_store_app/minor_screen/visit_store.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';

import '../wigets/alert_dialog.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statistics'
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];
List<Widget> pages = [
  VisitStore(suppId: FirebaseAuth.instance.currentUser!.uid),
  const SupplierOrders(),
  const EditBusiness(),
  const ManageProducts(),
  const BalanceScreen(),
  const StaticsScreen()
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Dasboard',
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyAlertDialog.showMyDialog(
                                      context: context, 
                                      title: 'Log Out', 
                                      content: 'Are you sure to log out ?',
                                      tabNo: (){
                                        Navigator.pop(context);
                                      },
                                      tabYes: 
                                         () async{
                                         await FirebaseAuth.instance.signOut();
                                         Navigator.pop(context);
                                         Navigator.pushReplacementNamed(context,  '/welcom_screen');
                                        },
                                      );
                        },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pages[index]));
                },
                child: Card(
                  elevation: 20,
                  shadowColor: Colors.blueAccent.shade200,
                  color: const Color.fromARGB(255, 79, 71, 67).withOpacity(0.7),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(icons[index],
                            size: 50,
                            color: const Color.fromARGB(255, 33, 212, 243)),
                        Text(
                          label[index].toUpperCase(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 33, 212, 243),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Acme'),
                        )
                      ]),
                ),
              );
            })),
      ),
    );
  }
}
