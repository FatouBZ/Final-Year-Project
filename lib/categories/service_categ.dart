import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../wigets/categ_widgets.dart';

class ServiceCategory extends StatelessWidget {
  const ServiceCategory({Key? key}) : super(key: key);

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
                  headerLabel: 'Services',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 70,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    children: List.generate(service.length -1, (index) {
                      return ServiceSubCategModel(
                        mainCategName2: 'service',
                        subCategName2: service[index +1],
                        assetName2: 'images/services/services$index.jpg',
                        subCategLable2: service[index +1],
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
        const Positioned(
            bottom: 0, right: 0, child: SlideBar(mainCategName: 'service'))
      ]),
    );
  }
}