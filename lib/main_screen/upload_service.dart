// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/wigets/snack_bar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';


class UploadServiceScreen extends StatefulWidget {
  const UploadServiceScreen({Key? key}) : super(key: key);

  @override
  State<UploadServiceScreen> createState() => _UploadServiceScreenState();
}

class _UploadServiceScreenState extends State<UploadServiceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey <FormState>();
    final GlobalKey<ScaffoldMessengerState> _scaffoldKey = 
    GlobalKey <ScaffoldMessengerState>();

    //late double price;
    //late String quantity;
    late String serviceName;
    late String serviceDesc;
    late String serviceID;
    late String duration;
    //int? discount = 0;
    String mainCategoryValue2 ='select service';
    String subCategoryValue2 = "subcategory";
    List<String> subCategoryList2= [];
    bool processing = false;


final ImagePicker _picker = ImagePicker();

  List<XFile>? imageFileList=[];
    List<String> imagesUrlList=[];

  dynamic _pickedImageError;

  void pickServiceImages()async {
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
                    if(value == "select service")
                    {
                      subCategoryList2 = [];
                    }  else if (value == 'service'){
                      subCategoryList2 = service;
                    }
                   /* else if (value == 'Compagny'){
                      subCategoryList2 = compagny;
                    }
                    else if (value == 'DigitalMarketing'){
                      subCategoryList2 = digitalmarketing;
                    }
                    else if (value == 'Wrriting&Translation'){
                      subCategoryList2 = wrritingtranslation;
                    }
                    else if (value == 'Business'){
                      subCategoryList2 = business;
                    }
                    else if (value == 'Graphic&Designe'){
                      subCategoryList2 = graphicdesigne;
                    }
                    else if (value == 'Video&Animation'){
                      subCategoryList2 = videoanimation;
                    }
                    else if (value == 'lifestyle'){
                      subCategoryList2 = lifestyle;
                    }*/
                    /*else if (value == 'bags'){
                      subCategoryList2 = bags;
                    }*/
                    /*
                    else if (value == 'service'){
                      subCategoryList2 = service;
                    }
                    else if (value == 'food'){
                      subCategoryList2 = food;
                    }*/
                    
                    print(value);
                    setState(() {
                      mainCategoryValue2 = value!;
                      subCategoryValue2 =  "subcategory";
                    });
}
Future <void> uploadImages ()async{
if(mainCategoryValue2!= 'select service' && subCategoryValue2!= 'subcategory'){
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
                    .ref('service/${path.basename(image.path)}');
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
    CollectionReference serviceRef = FirebaseFirestore.instance.collection('service');

    serviceID = const Uuid().v4();
                        await serviceRef.doc(serviceID).set({
                          'serviceid' : serviceID,
                          'maincategory': mainCategoryValue2,
                          'subcategory' :subCategoryValue2,
                         // 'price' :price,
                         // 'instock' :quantity,
                          'servicename' :serviceName,
                          'sid': FirebaseAuth.instance.currentUser!.uid,
                          'serviceimages' :imagesUrlList,
                         // 'discount' :discount,
                         'serviceduration' : duration,
                          'servicedescription': serviceDesc,
                        }).whenComplete(() {
                           setState(() {
                            processing = false;
                  imageFileList = [];
                  mainCategoryValue2 = 'select service';
                  subCategoryList2 = [];
                  imagesUrlList = [];
                });
                _formKey.currentState!.reset();
                        });
  }else{
    print('no images');
  }
}

void uploadService() async{
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
                         const Text('* select maincategory',
                         style: TextStyle(color: Colors.red)),
                        DropdownButton(
                          iconSize: 40,
                          iconEnabledColor: Colors.red,
                          iconDisabledColor: Colors.black,
                          dropdownColor: Colors.yellow.shade400,
                      value: mainCategoryValue2,
                      items:
                       servcateg.map<DropdownMenuItem<String>>((value) {
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
                      value: subCategoryValue2,
                      items: 
                      subCategoryList2.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                          );
                      }).toList(),
                   onChanged: (String ?value){
                      print(value);
                      setState(() {
                        subCategoryValue2 = value!;
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
                /*Row(
                  children: [
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
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextFormField(
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
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'please enter Service name';
                        }
                        return null;
                      },
                      onSaved: (value){
                        serviceName = value!;
                      },
                      maxLength: 100,
                      maxLines: 3,
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Service Name',
                        hintText: 'Enter Service name',
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
                          return 'please enter Service description';
                        }
                        return null;
                      },
                      onSaved: (value){
                        serviceDesc = value!;
                      },
                      maxLength: 800,
                      maxLines: 5,
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Service Description',
                        hintText: 'Enter Service description',
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
                          return 'please enter Service duration';
                        }
                        return null;
                      },
                      onSaved: (value){
                        duration = value!;
                      },
                      maxLength: 100,
                      maxLines: 5,
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Service Duration',
                        hintText: 'Enter Service Duration',
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
                pickServiceImages();
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
            uploadService();
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
/*extension QuantityValidator on String {
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
}     */              