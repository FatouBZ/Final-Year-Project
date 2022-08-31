import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../minor_screen/product_details.dart';
import '../minor_screen/service_detaile.dart';
import '../provider/wishlist_provider.dart';
import 'package:collection/collection.dart';

class ServiceModel extends StatefulWidget {
  final dynamic service;
  const ServiceModel({
    Key? key, required this.service
  }) : super(key: key);

  @override
  State<ServiceModel> createState() => _ServiceModelState();
}

class _ServiceModelState extends State<ServiceModel> {

 
  @override
  Widget build(BuildContext context) {
    return InkWell (
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>  ServiceDetailScreen(serviceList:widget.service)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
           Container(
            decoration: BoxDecoration( 
              color: Colors.white, borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                       borderRadius: BorderRadius.circular(15)),
                       child: Column(
                         children: [
                          Container(constraints: const BoxConstraints(minHeight: 100, maxHeight: 200),
                          child: Image(image: NetworkImage(widget.service['serviceimages'][0]),
                          ),
                          ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                                 Text(widget.service['servicename'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600
                                  ),
                                  ),
                                   Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /*Row(
                                  children: [
                                    Text(' ₵', 
                                    style: TextStyle(
                                    color: Colors.red.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                              ),),
                              Text(widget.products['price'].toStringAsFixed(2),
                              style: 
                              onSale !=0 ?
                              TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 11,
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
                               (((1-onSale/100)) * widget.products['price']).toStringAsFixed(2),
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
                                */
                              
                           widget.service['sid']  == FirebaseAuth.instance.currentUser!.uid    
                           ?IconButton( onPressed: (){},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ))
                                :IconButton(
                                             onPressed: (){},
                                              icon: const
                                              Icon(
                                            Icons.chat,
                                            color: Colors.red,
                                            size: 30,
                                          )
                                )
                                ],
                             ),
                               ],
                             ),
                           ),
                          
                          
                         ],
                       ),),
                ),
              ],
            ),
          ),
         /*widget.products['discount']  != 0? Positioned(
            top: 30,
            left: 0,
            child: Container(
              height: 25,
              width: 80,
              decoration: 
              const BoxDecoration
              (color:  Color.fromARGB(255, 33, 212, 243),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15))),
                child: Center(child: Text('Save ${widget.products ['discount'].toString()} %')),
            ),
          )
          :Container(color: Colors.transparent,)
          */
           ],
        ),
      ),
    );
  }
}