import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/main_screen/cart.dart';
import 'package:multi_store_app/main_screen/home.dart';
import 'package:multi_store_app/main_screen/profile.dart';
import 'package:multi_store_app/main_screen/stores.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import 'category.dart';
import 'package:badges/badges.dart';


class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs =  [
   const HomeScreen(),
   const CategoryScreen(),
   const StoresScreen(),
   const CartScreen(),
    ProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid,)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          currentIndex: _selectedIndex,
          items:  [
           const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
           const BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Category'),
          const  BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Stores'),
            BottomNavigationBarItem(
              
                icon: Badge(
                      showBadge: context.read<Cart>().getItems.isEmpty? false :true,
                      padding: const EdgeInsets.all(2),
                      badgeColor: const Color.fromARGB(255, 33, 212, 243),
                      badgeContent: Text(context.watch<Cart>().getItems.length.toString(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                child: const Icon (Icons.shopping_cart)), 
                label: 'Cart'
                ),
          const  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
