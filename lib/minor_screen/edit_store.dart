// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';
import 'package:multi_store_app/wigets/blue_button.dart';
import 'package:multi_store_app/wigets/snack_bar_widget.dart';

class EditStore extends StatefulWidget {
  final dynamic data;
  const EditStore({Key? key, required this.data}) : super(key: key);

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final GlobalKey<FormState> formeKey = GlobalKey<FormState>();
   final GlobalKey<ScaffoldMessengerState> scaffoldKey= GlobalKey<ScaffoldMessengerState>();

  XFile? imageFileLogo;
    XFile? imageFileCover;
    late String phone;
   late String storeName;
   late String storeLogo;
   late String storeCover;
   bool processing = false;


  dynamic _pickedImageError;
  final ImagePicker _picker = ImagePicker();


   pickStoreLogo() async{
    try {
      final pickStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileLogo = pickStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
   }
   pickCoverImage() async{
    try {
      final pickCoverImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileCover = pickCoverImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
   }



   uploadStoreLogo()async{
    if(imageFileLogo!= null){
       try {
      firebase_storage.Reference ref = firebase_storage
                              .FirebaseStorage.instance
                              .ref('supplier-images/${widget.data['email']}.jpg');

                              await ref.putFile(File(imageFileLogo!.path));
                              
                              storeLogo = await ref.getDownloadURL();
    }
    catch(e){
      print(e);
    }
   }else{
    storeLogo = widget.data['storelogo'];
   }
    }
   Future uploadCoverImage()async{
    if(imageFileCover!= null){
       try {
      firebase_storage.Reference ref2 = firebase_storage
                              .FirebaseStorage.instance
                              .ref('supplier-images/${widget.data['email']}.jpg-cover');

                              await ref2.putFile(File(imageFileCover!.path));
                              
                              storeCover = await ref2.getDownloadURL();
    }
    catch(e){
      print(e);
    }
   }else{
    storeCover = widget.data['coverimage'];
   }
    }
    editStoreData() async{
      await FirebaseFirestore.instance.runTransaction((transaction) async{
        DocumentReference documentReference = FirebaseFirestore.instance
        .collection('suppliers')
         .doc(FirebaseAuth.instance.currentUser!.uid);
         transaction.update(documentReference, {
          'storename' : storeName,
          'phone':phone,
          'storelogo':storeLogo,
          'coverimage':storeCover,
         });
      }).whenComplete(() => Navigator.pop(context));
    }
saveChanges() async{
  if(formeKey.currentState!.validate()){
    formeKey.currentState!.save();
    setState(() {
      processing = true;
    });
    await uploadStoreLogo().whenComplete(() async => await uploadCoverImage().whenComplete((() => editStoreData())));
  }else{
    MyMessageHandler.showSnackBar(scaffoldKey, 'Please fill all fields');
  }
}
   
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const
           AppBarTitle(
            title: 'edit store')),
            body: Form(
              key: formeKey,
              child: Column(
                children: [
                  Column(
                    children:  [
                   const Text('Store Logo',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600
                    ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(widget.data['storelogo']),
                        ),
                      Column(
                        children: [
                          BlueButton(label: 'Change', onPressed: (){
                            pickStoreLogo ();
                          }, width: 0.25),
                          const SizedBox(
                            height: 10,
                          ),
                        imageFileLogo == null ?
                        const SizedBox()  
                        :BlueButton(label: 'Reset', onPressed: (){
                            setState(() {
                              imageFileLogo = null;
                            }); 
                          }, width: 0.25),
                        ],
                      ),
                     imageFileLogo == null ? 
                     const SizedBox()
                     : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(imageFileLogo!.path)),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(8),
                    child: Divider(
                      color: Color.fromARGB(255, 33, 212, 243),
                      thickness: 2.5,),)
                  ]),
                  Column(
                    children:  [
                   const Text('Cover Image',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600
                    ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(widget.data['coverimage']),
                        ),
                      Column(
                        children: [
                          BlueButton(label: 'Change', onPressed: (){
                            pickCoverImage ();
                          }, width: 0.25),
                          const SizedBox(
                            height: 10,
                          ),
                        imageFileCover == null ?
                        const SizedBox()  
                        :BlueButton(label: 'Reset', onPressed: (){
                            setState(() {
                              imageFileCover = null;
                            }); 
                          }, width: 0.25),
                        ],
                      ),
                     imageFileCover == null ? 
                     const SizedBox()
                     : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(imageFileCover!.path)),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(8),
                    child: Divider(
                      color: Color.fromARGB(255, 33, 212, 243),
                      thickness: 2.5,),)
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField( 
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter Store Name';
                        }
                        return null;
                      },
                      onSaved: (value){
                        storeName = value!;
                      },
                      initialValue: widget.data['storename'],
                      decoration: textFormDecoration.copyWith(labelText: 'store name', hintText: ''),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                       validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter Your Phone Number';
                        }
                        return null;
                      },
                      onSaved: (value){
                        phone = value!;
                      },
                      initialValue: widget.data['phone'],
                      decoration: textFormDecoration.copyWith(labelText: 'phone', hintText: 'Enter Phone '),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      BlueButton(label: 'Cancel', onPressed: (){
                        null;
                      }, width: 0.25),
                     processing == true?
                      BlueButton(label: 'please wait ..', onPressed: (){
                        saveChanges();
                      }, width: 0.5)
                     : BlueButton(label: 'Save Changes', onPressed: (){
                        saveChanges();
                      }, width: 0.5)
                    ],),
                  )
                ],
              ),
            ),
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