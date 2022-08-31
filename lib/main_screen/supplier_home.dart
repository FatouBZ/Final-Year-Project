import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/main_screen/dashboard.dart';
import 'package:multi_store_app/main_screen/home.dart';
import 'package:multi_store_app/main_screen/stores.dart';
import 'package:multi_store_app/main_screen/upload.dart';
import 'package:multi_store_app/main_screen/upload_product.dart';
import 'package:multi_store_app/main_screen/upload_service.dart';
import '../wigets/blue_button.dart';
import 'category.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);
  

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = const[
     HomeScreen(),
     CategoryScreen(),
     StoresScreen(),
     DashboardScreen(),
     UploadProductScreen()
  ];

  @override
  Widget build(BuildContext context) {


return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection('orders')
        .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('deliverystatus', isEqualTo: 'preparing')
        .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
         
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child:   Center(child: CircularProgressIndicator(),));
        }
        

    return Scaffold(
      
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          currentIndex: _selectedIndex,
          items:  [
           const  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const  BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Category'),
          const  BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Stores'),
            BottomNavigationBarItem(
                icon: Badge(
                  showBadge: snapshot.data!.docs.isEmpty? false : true,
                      padding: const EdgeInsets.all(2),
                      badgeColor: const Color.fromARGB(255, 33, 212, 243),
                      badgeContent: Text(
                        snapshot.data!.docs.length.toString(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  
                  
                  child: const Icon(Icons.dashboard)), label: 'Dashboard'),
          const  
          BottomNavigationBarItem(
            icon: Icon(Icons.upload), label: 'Upload'),
          ],
          onTap: (index) {
            setState(() {
               

              
             /*if(index == 4){
                showModalBottomSheet(
                  useRootNavigator: true,
                          context: context,
                           builder: (context)=> SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Column( 
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children:   [
                                    Transform.scale(
                                      scale: 5,
                                       child: IconButton(
                                        onPressed: (){
                                          Navigator.push(context,
                                       MaterialPageRoute(builder: (context) => const UploadProductScreen()));
                                        },
                                     icon: const Icon(Icons.production_quantity_limits_rounded,  color: Color.fromARGB(255, 227, 208, 37))
                                      ),
                                       ),
                                     Transform.scale(
                                      scale: 5,
                                       child: IconButton(
                                        onPressed: (){Navigator.push(context,
                                       MaterialPageRoute(builder: (context) => const UploadServiceScreen()));},
                                     icon: const Icon(Icons.supervised_user_circle, color: Color.fromARGB(255, 227, 208, 37))
                                      ),
                                       ),
                                      //Icon(Icons.supervised_user_circle)
                                  ],),
                               /*const  Padding(
                                  padding:  EdgeInsets.only(top: 40),
                                  child: Text('Provide Service',
                                  style:  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ),*/
                                Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   
                                  children: [
                                  BlueButton(
                                  label: 'Products',
                                  onPressed: () {
                                    Navigator.push(context,
                                       MaterialPageRoute(builder: (context) => const UploadProductScreen()));
                                  },
                                  width: 0.40),
                                  BlueButton(
                                    label: 'Services',
                                    onPressed: () {
                                       Navigator.push(context,
                                       MaterialPageRoute(builder: (context) => const UploadServiceScreen()));
                                    },
                                    width: 0.40),
 
                                ],)
                               ])
                            )));
              }*/
               
              _selectedIndex = index;
            });
          }),
    );
  });
}
}
