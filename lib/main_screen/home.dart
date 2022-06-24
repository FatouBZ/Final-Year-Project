import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../minor_screen/search.dart';
import '../wigets/HomeSearch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreentState();
}

class _HomeScreentState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const HomeSearch(),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color.fromARGB(255, 33, 212, 243),
            indicatorWeight: 8,
            tabs: [
              RepeatedTab(label: 'Men'),
              RepeatedTab(label: 'Women'),
              RepeatedTab(label: 'Shoes'),
              RepeatedTab(label: 'Bags'),
              RepeatedTab(label: 'Electronics'),
              RepeatedTab(label: 'Accessories'),
              RepeatedTab(label: 'Home Appliances'),
              RepeatedTab(label: 'kids'),
              RepeatedTab(label: 'Beauty'),
              RepeatedTab(label: 'Services'),
              RepeatedTab(label: 'Company'),
              RepeatedTab(label: 'Foods'),

            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('men screen')),
            Center(child: Text('women screen')),
            Center(child: Text('shoes screen')),
            Center(child: Text('Bags screen')),
            Center(child: Text('Electronics screen')),
            Center(child: Text('Accessories screen')),
            Center(child: Text('Home Appliance screen')),
            Center(child: Text('kids screen')),
            Center(child: Text('Beauty screen')),
            Center(child: Text('Services screen')),
            Center(child: Text('Company screen')),
            Center(child: Text('Food screen')),
          ],
        ),
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
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
