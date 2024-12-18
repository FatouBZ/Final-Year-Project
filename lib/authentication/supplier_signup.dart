// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import "package:flutter/material.dart";
import '../../wigets/authentication_widget.dart';
import '../wigets/snack_bar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SupplierRegister extends StatefulWidget {
  const SupplierRegister({Key? key}) : super(key: key);

  @override
  State<SupplierRegister> createState() => _SupplierSignupState();
}

class _SupplierSignupState extends State<SupplierRegister> {
  late String storeName;
  late String email;
  late String password;
  late String storeLogo;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordvisible = false;

  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  dynamic _pickedImageError;

  CollectionReference suppliers = FirebaseFirestore.instance.collection('suppliers');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

void signUp() async{
  setState(() {
    processing = true;
  });
   if (_formKey.currentState!.validate()) {
                            if (_imageFile != null) {
                              try{
                                await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(email: email, password: password);
                             

                              firebase_storage.Reference ref = firebase_storage
                              .FirebaseStorage.instance
                              .ref('supplier-images/$email.jpg');

                              await ref.putFile(File(_imageFile!.path));
                              _uid = FirebaseAuth.instance.currentUser!.uid;
                              storeLogo = await ref.getDownloadURL();
                              await suppliers.doc(FirebaseAuth.instance.currentUser!.uid).set({
                                'storename': storeName,
                                'email': email,
                                'storelogo': storeLogo,
                                'phone': '',
                                'sid': _uid,
                                'coverimage': '',
                              });
                               _formKey.currentState!.reset();
                              setState(() {
                                _imageFile = null;
                              });
                              await Future.delayed(const Duration(microseconds: 100)).whenComplete(() => 
                              Navigator.pushReplacementNamed(context, '/supplier_login')
                              );
                              
                              } on FirebaseAuthException catch(e){
                                if (e.code == 'weak-password') {
                                  setState(() {
                              processing = false;
                            });
                                  MyMessageHandler.showSnackBar(
                                  _scaffoldKey, 'The password provided is too weak.');
                                   } else if (e.code == 'email-already-in-use') {
                                    setState(() {
                              processing = false;
                            });
                                     MyMessageHandler.showSnackBar(
                                  _scaffoldKey, 'The account already exists for that email.');
                                     }
                              }
                              
                            } else{ 
                             setState(() {
                              processing = false;
                            });
                              MyMessageHandler.showSnackBar(
                                  _scaffoldKey, 'Please pick image first');
                            }
                          } else {
                            setState(() {
                              processing = false;
                            });
                            MyMessageHandler.showSnackBar(
                                _scaffoldKey, 'Please fill all fields');
                          }
}
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: authenticationHeaderLabel(
                          headerLabel: 'Sign Up',
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.blue,
                              backgroundImage: _imageFile == null
                                  ? null
                                  : FileImage(File(_imageFile!.path)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt,
                                      color: Colors.white),
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.photo,
                                      color: Colors.white),
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('Please enter your full name');
                              }
                              return null;
                            },
                            onChanged: (value) {
                              storeName = value;
                            },
                            // controller: _nameController,
                            decoration: textFormDecoration.copyWith(
                                labelText: 'Store Name',
                                hintText: 'Enter your store name')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('Please enter your email');
                            } else if (value.isValidEmail() == false) {
                              return 'Invalid Email';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          //controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Email Address',
                              hintText: 'Enter your email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('Please enter your password');
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            //controller: _passwordController,
                            obscureText: passwordvisible,
                            decoration: textFormDecoration.copyWith(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordvisible = !passwordvisible;
                                      });
                                    },
                                    icon: Icon(
                                      passwordvisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.blue,
                                    )),
                                labelText: 'Password',
                                hintText: 'Enter your Password')),
                      ),
                      HaveAccount(
                        haveAccount: 'already have account?',
                        actionLabel: 'Log In',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context, '/supplier_login');
                        },
                      ),
                     processing ==true  
                     ?const CircularProgressIndicator()
                     : AuthenticationMainButton(
                        mainButtonLabel: 'Sign Up',
                        onPressed: (){
                        signUp();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
