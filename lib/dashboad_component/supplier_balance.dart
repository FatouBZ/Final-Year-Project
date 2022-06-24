import 'package:flutter/material.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Balance '),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
  