import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../wigets/categ_widgets.dart';

class HomeApplianceCategory extends StatelessWidget {
  const HomeApplianceCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CategHeaderLabel(
                  headerLabel: 'Home & Appliance',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 70,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    children: List.generate(homeandgarden.length, (index) {
                      return SubCategModel(
                        mainCategName: 'HomeAppliance',
                        subCategName: homeandgarden[index],
                        assetName: 'images/homegarden/home$index.jpg',
                        subCategLable: homeandgarden[index],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
            bottom: 0,
            right: 0,
            child: SlideBar(mainCategName: 'Home & Garden'))
      ]),
    );
  }
}
