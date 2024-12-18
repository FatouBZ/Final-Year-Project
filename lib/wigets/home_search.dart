import 'package:flutter/material.dart';

import '../minor_screen/search.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchScreen()));
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 33, 212, 243), width: 1.4),
            borderRadius: BorderRadius.circular((25))),
        child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'What are you looking for?',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
          ),
          Container(
              height: 32,
              width: 75,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 212, 243),
                  borderRadius: BorderRadius.circular((25))),
              child: const Center(
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
          )
        ]),
            ),
      ),
    );
  }
}
