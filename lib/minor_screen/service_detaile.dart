import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/main_screen/cart.dart';
import 'package:multi_store_app/minor_screen/full_screen_view.dart';
import 'package:multi_store_app/minor_screen/product_details.dart';
import 'package:multi_store_app/minor_screen/visit_store.dart';
import 'package:multi_store_app/models/service_model.dart';
import 'package:multi_store_app/provider/cart_provider.dart';
import 'package:multi_store_app/provider/wishlist_provider.dart';
import 'package:multi_store_app/wigets/blue_button.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';
import 'package:multi_store_app/wigets/snack_bar_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:badges/badges.dart';
class ServiceDetailScreen extends StatefulWidget {
  final dynamic serviceList;
  const ServiceDetailScreen({Key? key, required this.serviceList}) : super(key: key);
   

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  late final Stream<QuerySnapshot> _serviceListStream =
   FirebaseFirestore.instance.collection('serviceList')
   .where('maincategory', isEqualTo: widget.serviceList['maincategory'])
   .where('subcategory', isEqualTo: widget.serviceList['subcategory'])
   .snapshots();
   /*late final Stream<QuerySnapshot> reviewsStream =
   FirebaseFirestore.instance.collection('service')
   .doc(widget.serviceList['serviceid']).collection('reviews')
   .snapshots();*/
  


  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
   late List<dynamic> imagesList = widget.serviceList['serviceimages'];
  @override
  Widget build(BuildContext context) {
    //var onSale = widget.proList['discount'];
     /*var existingItemCart = context.read<Cart>()
                .getItems.firstWhereOrNull((product)
                 => product.documentId == widget
                 .proList['productid']);*/
    
    return  Material(
      child: SafeArea (
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               InkWell(
                onTap:(){
                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>  FullScreenView(imageList: imagesList,)));
                },
                
                  child: Stack(children: [
                     SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Swiper(
                        pagination: const SwiperPagination(builder: SwiperPagination.fraction),
                        itemBuilder: (contex, index){
                        return  Image(
                          image: NetworkImage(
                            imagesList[index],
                          ),
                          );
                      }, itemCount: imagesList.length
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 20,
                      child: CircleAvatar(backgroundColor: 
                    const  Color.fromARGB(255, 33, 212, 243),
                     child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.black),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                     ))
                     ),
                               Positioned(
                      right: 15,
                      top: 20,
                      child: CircleAvatar(backgroundColor: 
                    const  Color.fromARGB(255, 33, 212, 243),
                     child: IconButton(
                      icon: const Icon(Icons.share,
                      color: Colors.black),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                     ))
                     ),
                  ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.serviceList['servicename'],
                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                        ),
                                        ),
                      /* Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                     
                                Row(
                                  children: [
                                    Text(' GH₵', 
                                    style: TextStyle(
                                    color: Colors.red.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                              ),),
                              Text(widget.proList['price'].toStringAsFixed(2),
                              style: 
                              onSale !=0 ?
                              TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w600
                              )
                              :TextStyle(
                                color: Colors.red.shade600,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                              const SizedBox(width: 6),
                              onSale !=0?
                              Text(
                               (((1-onSale/100)) * widget.proList['price']).toStringAsFixed(2),
                              style:
                             
                               TextStyle(
                                color: Colors.red.shade600,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              )
                              )
                              :const Text (''),
                                  ],
                                ),
                    IconButton(
                                 onPressed: (){
                 var existingItemWishlist = context
                .read<Wish>()
                .getWishItems
                .firstWhereOrNull((product)
                 => product.documentId == 
                 widget.proList['productid']);
                 
                existingItemWishlist !=
                 null 
                 ? context
                 .read<Wish>()
                 .removeThis(widget.proList['productid'])
                 : context.read<Wish>().addWishItem(
                    widget.proList['productname'],
                    onSale !=0?  (((1-onSale/100)) * widget.proList['price']).toStringAsFixed(2)
                    :widget.proList['price'], 
                    1,
                    widget.proList['instock'], 
                    widget.proList['prodimages'],
                    widget.proList['productid'],
                    widget.proList['sid'],
                  );
                                  },
                    icon: context
                                    .watch<Wish>()
                                    .getWishItems
                                   .firstWhereOrNull((product)
                                   => product.documentId == 
                                     widget.proList['productid']) !=
                                    null 
                                  ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  )
                                  :const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red, 
                                    size: 30,
                                  ))
                  ],
                  ),*/
                   /*widget.proList['instock'] == 0 
                   ? const Text('This Item is out of stock',
                   style:  TextStyle(fontSize: 16, 
                  color: Colors.blueGrey),) 
                   :Text(
                    (widget.proList['instock'].toString())+(' pieces in stock'),
                  style: const TextStyle(fontSize: 16, 
                  color: Colors.blueGrey)
                  ),*/
                    ],
                  ),
                ),
                

               const serviceDetailHeader(
                
                label: 'Service Description'
               ),
               Text( 
                widget.serviceList['servicedescription'],
               textScaleFactor: 1.1,
               style: TextStyle(
                fontSize:20,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade800,
               ),
               ),
               

               /*ExpandableTheme(
                       data: const ExpandableThemeData(
                       iconSize: 30,
                      iconColor: Colors.blue),
                     child: reviews(reviewsStream)),*/

                      const serviceDetailHeader(label: ' Similar Services ',
                      ),
                    SizedBox(child: StreamBuilder<QuerySnapshot>(
                  stream: _serviceListStream,
                     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const  Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.data!.docs.isEmpty){
                  return const Center(child:  Text('',
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
                ))
              ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => 
                     // VisitStore(suppId: widget.proList['sid'],),));
                    }, icon: const Icon(Icons.store)),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(onPressed: (){}, 
                    icon:const Icon(Icons.chat_bubble_outline_sharp)
                      ),
                      
                  ],
                ),

                /*BlueButton(
                  label: existingItemCart != null ?'added to cart' :'ADD TO CART', 
                onPressed: (){
                  if (widget.proList['instock'] == 0){
                     MyMessageHandler.showSnackBar(_scaffoldKey, 'This item is out of stock');
                  }else if(existingItemCart !=null ){
                    MyMessageHandler.showSnackBar(_scaffoldKey, 'This item is already in cart');
                  } else{
                    context.read<Cart>().addItem(
                    widget.proList['productname'], 
                    onSale !=0?  (((1-onSale/100)) * widget.proList['price'])
                    :widget.proList['price'], 
                    1,
                    widget.proList['instock'], 
                    widget.proList['prodimages'],
                    widget.proList['productid'],
                    widget.proList['sid'],
                  );
                  } 
                }, width: 0.55)*/
              ],),
            ),
          ),
        ),
      ),
    );
  }
}















// ignore: camel_case_types
class  serviceDetailHeader extends StatelessWidget {
  final String label;
  const serviceDetailHeader({
    Key? key, required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, 
       children: [
    const SizedBox(
      height: 40,
      width: 50,
      child: Divider(
        color: Color.fromARGB(255, 245, 127, 23),
        thickness: 1,
      ),
    ),
    Text(
      label,
      style: const TextStyle(
          color: Color.fromARGB(255, 245, 127, 23), 
          fontSize: 24,
           fontWeight: FontWeight.w600),
    ),
   const  SizedBox(
      height: 40,
      width: 50,
      child: Divider(
        color: Color.fromARGB(255, 245, 127, 23),
        thickness: 1,
      ),
    ),
      ]),
    );
  }
}

/*Widget reviews( var reviewsStream){
  return ExpandablePanel(
    header: const Padding(
      padding: EdgeInsets.all(10),
      child: Text('Reviews',
      style: TextStyle(
        color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold
      )
      ),),
    collapsed:  SizedBox(height: 230, 
    child: reviewsAll (reviewsStream) ),
    expanded: reviewsAll (reviewsStream));
}
Widget reviewsAll(var reviewsStream){
return StreamBuilder<QuerySnapshot>(
      stream: reviewsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
      
        if (snapshot2.connectionState == ConnectionState.waiting) {
          return const  Center(child: CircularProgressIndicator(),);
        }
        if(snapshot2.data!.docs.isEmpty){
          return const Center(child:  Text('No Reviews yet !',
          style: TextStyle(fontSize: 26, color: Colors.blueGrey,
           fontWeight: FontWeight.bold, fontFamily: 'Acme', letterSpacing: 1.5),));
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot2.data!.docs.length,
          itemBuilder: (context, index){
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                snapshot2.data!.docs[index]['profileimage'])),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(snapshot2.data!.docs[index]['name']),
                  Row(children: [
                  Text(snapshot2.data!.docs[index]['rate'].toString()),
                  const Icon(Icons.star,color: Colors.amber,)
                ]),
                ]),
                
                subtitle: Text(snapshot2.data!.docs[index]['comment']),
                
          );
        });
      },
    );
}*/