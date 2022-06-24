import 'package:flutter/material.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';

// ignore: camel_case_types
class WishlistsScreen extends StatelessWidget {
  const WishlistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Wishlists '),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
