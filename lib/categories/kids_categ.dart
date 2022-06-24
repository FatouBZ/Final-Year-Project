import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../wigets/categ_widgets.dart';

class KidCategory extends StatelessWidget {
  const KidCategory({Key? key}) : super(key: key);
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
                  headerLabel: 'Kids',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 70,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    children: List.generate(kids.length, (index) {
                      return SubCategModel(
                        mainCategName: 'Kids',
                        subCategName: kids[index],
                        assetName: 'images/kids/kids$index.jpg',
                        subCategLable: kids[index],
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
        const Positioned(
            bottom: 0, right: 0, child: SlideBar(mainCategName: 'Kids'))
      ]),
    );
  }
}
