import 'package:flutter/material.dart';

import '../wigets/appbar_widget.dart';

class SubCategProducts extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  const SubCategProducts(
      {Key? key, required this.subCategName, required this.mainCategName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: AppBarTitle(title: subCategName),
      ),
      body: Center(
        child: Text(mainCategName),
      ),
    );
  }
}

