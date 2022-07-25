// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/wigets/snackBar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';


class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey <FormState>();
    final GlobalKey<ScaffoldMessengerState> _scaffoldKey = 
    GlobalKey <ScaffoldMessengerState>();

    late double price;
    late int quantity;
    late String proName;
    late String proDesc;
    late String proID;
    String mainCategoryValue ='select category';
    String subCategoryValue = "subcategory";
    List<String> subCategoryList = [];
    bool processing = false;


final ImagePicker _picker = ImagePicker();

  List<XFile>? imageFileList=[];
    List<String> imagesUrlList=[];

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
Future <void> uploadImages ()async{
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
                          'prodimages' : imagesUrlList,
                          'discount' : 0,
                          'productdescription': proDesc,
                        }).whenComplete(() {
                           setState(() {
                            processing = false;
                  imageFileList = [];
                  mainCategoryValue = 'select category';
                  subCategoryList = [];
                  imagesUrlList = [];
                });
                //_formKey.currentState!.reset();
                        });
  }else{
    print('no images');
  }
}

void uploadProduct() async{
  await uploadImages().whenComplete(() => uploadData());
}
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
                          child: Text(value), 
                          value: value);
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
                          child: Text(value), 
                          value: value,
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
                
                const SizedBox(
                  height: 30,
                  child: Divider(color: Colors.yellow,
                  thickness: 1.5
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: TextFormField(
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
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
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
              ]),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              onPressed: imageFileList!.isEmpty? (){
                pickProductImages();
              }:(){
                setState(() {
                  imageFileList = [];
                });
              },
               backgroundColor: Colors.yellow, 
               child:
               imageFileList!.isEmpty? const Icon(Icons.photo_library, color: Colors.black,)
                :const Icon(Icons.delete_forever, color: Colors.black,),
               ),
          ),
              FloatingActionButton(
            onPressed: processing == true
            ? null 
            : (){
            uploadProduct();
            },
             backgroundColor: Colors.yellow, 
             child:  processing == true 
             ? const CircularProgressIndicator(color: Colors.black,) 
             : const Icon(
              Icons.upload, color: Colors.black,),
             ),
        ]),
      ),
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