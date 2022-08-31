// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/wigets/blue_button.dart';
import 'package:multi_store_app/wigets/button.dart';
import 'package:multi_store_app/wigets/snack_bar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';


class EditProduct extends StatefulWidget {
  final dynamic items;
  const EditProduct({Key? key, required this.items}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey <FormState>();
    final GlobalKey<ScaffoldMessengerState> _scaffoldKey = 
    GlobalKey <ScaffoldMessengerState>();

    late double price;
    late int quantity;
    late String proName;
    late String proDesc;
    late String proID;
    int ? discount = 0;
    String mainCategoryValue ='select category';
    String subCategoryValue = "subcategory";
    List<String> subCategoryList = [];
    bool processing = false;


final ImagePicker _picker = ImagePicker();

  List<XFile>? imageFileList=[];
    List<dynamic> imagesUrlList=[];

  dynamic _pickedImageError;

  void pickProductImages()async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileList = pickedImages!;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

Widget previwImages(){
  if (imageFileList!.isNotEmpty){
return ListView.builder(
      itemCount: imageFileList!.length,
      itemBuilder: (context, index){
      return Image.file(File(imageFileList![index].path));
    });
  }else{
   return const Center(child: Text('you have not \n \n picked images yet !',
                      textAlign: TextAlign.center,
                       style: TextStyle(fontSize: 16),),);
  }
}
Widget previwCurrentImages(){
  List<dynamic> itemImages = widget.items['prodimages'];
  return ListView.builder(
    itemCount: itemImages.length,
    itemBuilder: (context, index){
    return Image.network(itemImages[index].toString());
  } );
}
void selectedMainCategory (String ? value){
                    if(value == "select category")
                    {
                      subCategoryList = [];
                    }  else if (value == 'men'){
                      subCategoryList = men;
                    }
                    else if (value == 'women'){
                      subCategoryList = women;
                    }
                    else if (value == 'electronics'){
                      subCategoryList = electronics;
                    }
                    else if (value == 'accessories'){
                      subCategoryList = accessories;
                    }
                    else if (value == 'shoes'){
                      subCategoryList = shoes;
                    }
                    else if (value == 'home & garden'){
                      subCategoryList = homeandgarden;
                    }
                    else if (value == 'beauty'){
                      subCategoryList = beauty;
                    }
                    else if (value == 'kids'){
                      subCategoryList = kids;
                    }
                    else if (value == 'bags'){
                      subCategoryList = bags;
                    }/*
                    else if (value == 'service'){
                      subCategoryList = service;
                    }
                    else if (value == 'food'){
                      subCategoryList = food;
                    }*/
                    
                    print(value);
                    setState(() {
                      mainCategoryValue = value!;
                      subCategoryValue =  "subcategory";
                    });
}
Future uploadImages() async{
  if(_formKey.currentState!.validate()){
_formKey.currentState!.save();
if(imageFileList!.isNotEmpty){
  if(mainCategoryValue!= 'select category' &&
   subCategoryValue!= 'subcategory'){
try{
                  for(var image in imageFileList!){
                    firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('products/${path.basename(image.path)}');
                    await  ref.putFile(File(image.path)).whenComplete(() async{
                      await ref.getDownloadURL().then((value){
                        imagesUrlList.add(value);
                      });
                    });
                  }
}catch(e){
  print(e);
}
  
  }else{
       MyMessageHandler.showSnackBar((_scaffoldKey), 'please select categories');
       }

  }else{
    imageFileList = widget.items['prodimages'];
  }

  }else{
       MyMessageHandler.showSnackBar((_scaffoldKey), 'please fill all fields');
    }
                
}

editProductData() async{
await FirebaseFirestore.instance.runTransaction((transaction) async{
  DocumentReference documentReference = FirebaseFirestore.instance
  .collection('products').doc(widget.items['productid']);
  transaction.update(documentReference, {
                          'maincategory': mainCategoryValue,
                          'subcategory' :subCategoryValue,
                          'price' :price,
                          'instock' :quantity,
                          'productname' :proName,
                          'prodimages' :imagesUrlList,
                          'discount' : discount,
                          'productdescription': proDesc,
  });
}).whenComplete(() => Navigator.pop(context));
}
saveChanges() async{
  await uploadImages().whenComplete(() => editProductData());
}
/*Future <void> uploadImages ()async{
if(mainCategoryValue!= 'select category' && subCategoryValue!= 'subcategory'){
    if(_formKey.currentState!.validate()){
                _formKey.currentState!.save();
                if(imageFileList!.isNotEmpty){
                  setState(() {
                    processing = true;
                  });
              try{
                  for(var image in imageFileList!){
                    firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('products/${path.basename(image.path)}');
                    await  ref.putFile(File(image.path)).whenComplete(() async{
                      await ref.getDownloadURL().then((value){
                        imagesUrlList.add(value);
                      });
                    });
                  }
}catch(e){
  print(e);
}
                }else{
                  MyMessageHandler.showSnackBar((_scaffoldKey), 'please pick an images first');
                }
               
              }
              else{
                MyMessageHandler.showSnackBar((_scaffoldKey), 'please fill all fields');
              }
             }else{
                  MyMessageHandler.showSnackBar((_scaffoldKey), 'please select categories');
                }
}
void uploadData () async{
  if(imagesUrlList.isNotEmpty){
    CollectionReference produductRef = FirebaseFirestore.instance.collection('products');

    proID = const Uuid().v4();
                        await produductRef.doc(proID).set({
                          'productid' : proID,
                          'maincategory': mainCategoryValue,
                          'subcategory' :subCategoryValue,
                          'price' :price,
                          'instock' :quantity,
                          'productname' :proName,
                          'sid': FirebaseAuth.instance.currentUser!.uid,
                          'prodimages' :imagesUrlList,
                          'discount' : discount,
                          'productdescription': proDesc,
                        }).whenComplete(() {
                           setState(() {
                            processing = false;
                  imageFileList = [];
                  mainCategoryValue = 'select category';
                  subCategoryList = [];
                  imagesUrlList = [];
                });
                _formKey.currentState!.reset();
                        });
  }else{
    print('no images');
  }
}

void uploadProduct() async{
  await uploadImages().whenComplete(() => uploadData());
}*/
  @override
  Widget build(BuildContext context) {
    var size =  MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Column(
                     children: [
                       Row(children: [
                  Container(
                          color: Colors.blueGrey.shade100,
                          height: size.width * 0.5,
                          width: size.width * 0.5,
                          child: previwCurrentImages()),
                        SizedBox(
                          height: size.width * 0.5,
                          width: size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                  Column(
                          children: [
                           const  Text('  main category',
                            style: TextStyle(color: Colors.red),),
                              Container(
                              padding: const EdgeInsets.all(6),
                               margin: const EdgeInsets.all(6),
                              constraints: BoxConstraints(minWidth: size.width *0.3),
                              decoration: 
                             BoxDecoration(
                              color: const Color.fromARGB(255, 33, 212, 243),
                              borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text(widget.items['maincategory'],
                               style:const  TextStyle(color: Colors.black, fontWeight: FontWeight.bold), )),)
                          ],
                  ),
                  
                       Column(
                           children: [
                             const Text(' subcategory',
                             style: TextStyle(color: Colors.red)),
                             Container(
                              padding: const EdgeInsets.all(6),
                               margin: const EdgeInsets.all(6),
                              constraints: BoxConstraints(minWidth: size.width *0.3),
                              decoration: 
                             BoxDecoration(
                              color: const Color.fromARGB(255, 33, 212, 243),
                              borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text(widget.items['subcategory'],
                             style:const  TextStyle(color: Colors.black, fontWeight: FontWeight.bold), )),)
                           ],
                       ),
                  
                ],),
                        ),
                ],),

                 ExpandablePanel(
                  theme: const  ExpandableThemeData(hasIcon: false),
    header:  Padding(
      padding: const EdgeInsets.all(10),
      child:   Container(
        decoration: BoxDecoration( color: const  Color.fromARGB(255, 33, 212, 243),
        borderRadius: BorderRadius.circular(10),),
        padding: const EdgeInsets.all(6),
        child: const Center(
          child:  Text('Change Images & Categories',
          style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
          )
          ),
        ),
      ),),
    collapsed: const SizedBox(),
    expanded: changeImages(size)),
                     ],
                   ),
                
                const SizedBox(
                  height: 30,
                  child: Divider(color: Colors.yellow,
                  thickness: 1.5
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextFormField(
                          initialValue: widget.items['price'].toStringAsFixed(2),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'please enter price';
                            }else if(value.isValidPrice()!=true){
                              return 'invalid price';
                            }
                            return null;
                          },
                          onSaved: (value){
                            price = double.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Price',
                            hintText: 'price .. ₵',
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextFormField(
                          initialValue: widget.items['discount'].toString(),
                          maxLength: 2,
                          validator: (value){
                            if(value!.isEmpty){
                              return null;
                            }else if(value.isValidDiscount()!=true){
                              return 'invalid discount';
                            }
                            return null;
                          },
                          onSaved: (value){
                           //discount = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Discount',
                            hintText: 'discount .. %',
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      initialValue: widget.items['instock'].toString(),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'please enter quantity';
                        }else if(value.isValidQuantity()!=true){
                          return 'not valid quantity';
                        }
                        return null;
                      },
                      onSaved: (value){
                        quantity = int.parse(value!);
                      },
                      keyboardType: TextInputType.number,
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Quantity',
                        hintText: 'Add Quantity',
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      initialValue: widget.items['productname'],
                      validator: (value){
                        if(value!.isEmpty){
                          return 'please enter product name';
                        }
                        return null;
                      },
                      onSaved: (value){
                        proName = value!;
                      },
                      maxLength: 100,
                      maxLines: 3,
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Product Name',
                        hintText: 'Enter product name',
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      initialValue: widget.items['productdescription'],
                      validator: (value){
                        if(value!.isEmpty){
                          return 'please enter product description';
                        }
                        return null;
                      },
                      onSaved: (value){
                        proDesc = value!;
                      },
                      maxLength: 800,
                      maxLines: 5,
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Product Description',
                        hintText: 'Enter product description',
                      )
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      BlueButton(label: 'Cancel',
                       onPressed: (){
                        Navigator.pop(context);
                       }, width: 0.25),
                       BlueButton(label: 'Save Changes',
                       onPressed: (){
                       saveChanges();
                       }, width: 0.50)
                    ],),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Button(label: 'Delete Item', onPressed: () async{
                         await FirebaseFirestore.instance.runTransaction((transaction) async{
                          DocumentReference documentReference = FirebaseFirestore.instance
                          .collection('products').doc(widget.items['productid']);
                          transaction.delete(documentReference);
                         }).whenComplete(() => Navigator.pop(context));
                      
                      }, width: 0.5),
                    )
                  ],
                )
              ]),
            ),
          ),
        ),
        
       
      ),
    );
  }
 
Widget changeImages(Size size){
  return  Column(
    children: [
      Row(children: [
                      Container(
                          color: Colors.blueGrey.shade100,
                          height: size.width * 0.5,
                          width: size.width * 0.5,
                          child: imageFileList != null ? previwImages():                   
                          const Center(child: Text('you have not \n \n picked images yet !',
                          textAlign: TextAlign.center,
                           style: TextStyle(fontSize: 16),),),
                        ),
                        SizedBox(
                          height: size.width * 0.5,
                          width: size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                      Column(
                          children: [
                           const  Text(' * select main category',
                            style: TextStyle(color: Colors.red),),
                             DropdownButton(
                              iconSize: 40,
                              iconEnabledColor: Colors.red,
                              dropdownColor: Colors.yellow.shade400,
                          value: mainCategoryValue,
                          items:
                           maincateg.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem(
                                value: value,
                              child: Text(value));
                          }).toList(),
                       onChanged: (String? value){
                          selectedMainCategory(value);
                       }),
                          ],
                      ),
                      
                       Column(
                           children: [
                             const Text('* select subcategory',
                             style: TextStyle(color: Colors.red)),
                             DropdownButton(
                              iconSize: 40,
                              iconEnabledColor: Colors.red,
                              iconDisabledColor: Colors.black,
                              dropdownColor: Colors.yellow.shade400,
                              menuMaxHeight: 500,
                          disabledHint: const Text('select category',),
                          value: subCategoryValue,
                          items: 
                          subCategoryList.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                              );
                          }).toList(),
                       onChanged: (String ?value){
                          print(value);
                          setState(() {
                            subCategoryValue = value!;
                          });
                       }),
                           ],
                       ),
                      
                       
                    ],),
                        ),
                    ],),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: imageFileList!.isNotEmpty?
                       BlueButton(label: 'Reset Images', onPressed: (){
                        setState(() {
                          imageFileList = [];
                        });
                        
                      }, width: 0.6)
                      :BlueButton(label: 'Change Images', onPressed: (){
                        pickProductImages();
                      }, width: 0.6),
                    )
    ],
  );
}

}
var textFormDecoration = InputDecoration(
                    labelText: 'price',
                    hintText: 'price .. ₵',
                    labelStyle: const TextStyle(color: Colors.cyan),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)), 
                      enabledBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.yellow, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                      focusedBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                      
                  );
extension QuantityValidator on String {
  bool isValidQuantity () {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);                                                            
  }
}     
extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$').hasMatch(this);                                                            
  }
}     
extension DiscountValidator on String {
  bool isValidDiscount() {
    return RegExp(r'^([0-9]*)$').hasMatch(this);                                                            
  }
}             