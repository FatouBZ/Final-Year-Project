import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/models/service_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';
import '../wigets/appbar_widget.dart';

class SubCategService extends StatefulWidget {
  final String mainCategName2;
  final String subCategName2;
  const SubCategService(
      {Key? key, required this.subCategName2, required this.mainCategName2})
      : super(key: key);

  @override
  State<SubCategService> createState() => _SubCategServiceState();
}

class _SubCategServiceState extends State<SubCategService> {

  @override
  Widget build(BuildContext context) {
final Stream<QuerySnapshot> serviceStream = FirebaseFirestore.instance
 .collection('service')
 .where('maincategory', isEqualTo: widget.mainCategName2)
  .where('subcategory', isEqualTo: widget.subCategName2)

 .snapshots();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: AppBarTitle(title: widget.subCategName2),
      ),
      body:StreamBuilder<QuerySnapshot>(
      stream: serviceStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const  Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.data!.docs.isEmpty){
          return const Center(child:  Text('This Category \n\n has no items yet !',
          style: TextStyle(fontSize: 26, color: Colors.blueGrey,
           fontWeight: FontWeight.bold, fontFamily: 'Acme', letterSpacing: 1.5),));
        }
        return SingleChildScrollView (
          child: StaggeredGridView.countBuilder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            crossAxisCount: 2,
           itemBuilder: (context,index){
            return ServiceModel(service: snapshot.data!.docs[index],);
           },
            staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
        );
      },
    ),
    );
  }
}

