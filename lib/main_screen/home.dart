import 'package:flutter/material.dart';
import '../gallery/accessories_galery.dart';
import '../gallery/bags_galery.dart';
import '../gallery/beauty_category.dart';
import '../gallery/electronics_galery.dart';
import '../gallery/home_appliance_galery.dart';
import '../gallery/kids_galery.dart';
import '../gallery/men_gallery.dart';
import '../gallery/shoes_galery.dart';
import '../gallery/women_galery.dart';
import '../wigets/home_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreentState();
}

class _HomeScreentState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
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
              //RepeatedTab(label: 'Services'),
              //RepeatedTab(label: 'Company'),
              //RepeatedTab(label: 'Foods'),

            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MenGalleryScreen(),
            WomenGalleryScreen(),
            ShoesGalleryScreen(),
            BagsGalleryScreen(),
            ElectronicsGalleryScreen(),
            AccessoriesGalleryScreen(),
            HomeGalleryScreen(),
            KidsGalleryScreen(),
           BeautyGalleryScreen()
            //Center(child: Text('Services screen')),
            //Center(child: Text('Company screen')),
            //Center(child: Text('Food screen')),
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
