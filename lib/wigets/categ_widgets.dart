import 'package:flutter/material.dart';
import '../minor_screen/subcateg_products.dart';
import '../minor_screen/subcateg_services.dart';

class SlideBar extends StatelessWidget {
  final String mainCategName;
  const SlideBar({
    Key? key,
    required this.mainCategName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.05,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50)),
              child: RotatedBox(
                quarterTurns: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mainCategName == 'service'
                        ? const Text('')
                        : const Text(
                            ' << ',
                            style: style,
                          ),
                    Text(
                      mainCategName.toUpperCase(),
                      style: style,
                    ),
                    mainCategName == 'men'
                        ? const Text('')
                        : const Text(
                            ' >> ',
                            style: style,
                          ),
                  ],
                ),
              )),
        ));
  }
}

const style = TextStyle(
    color: Colors.brown,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 10);

class SubCategModel extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subCategLable;
  const SubCategModel({
    Key? key,
    required this.mainCategName,
    required this.subCategName,
    required this.assetName,
    required this.subCategLable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCategProducts(
                      mainCategName: mainCategName,
                      subCategName: subCategName,
                    )));
      },
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image(image: AssetImage(assetName)),
          ),
          Text(subCategLable, style: const TextStyle(fontSize: 10))
        ],
      ),
    );
  }
}
class ServiceSubCategModel extends StatelessWidget {
  final String mainCategName2;
  final String subCategName2;
  final String assetName2;
  final String subCategLable2;
  const ServiceSubCategModel({
    Key? key,
    required this.mainCategName2,
    required this.subCategName2,
    required this.assetName2,
    required this.subCategLable2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCategService(
                      mainCategName2: mainCategName2,
                      subCategName2: subCategName2,
                    )));
      },
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image(image: AssetImage(assetName2)),
          ),
          Text(subCategLable2, style: const TextStyle(fontSize: 10))
        ],
      ),
    );
  }
}

class CategHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const CategHeaderLabel({Key? key, required this.headerLabel})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        headerLabel,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }
}
