// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import '../wigets/authentication_widget.dart';
import '../wigets/snackBar_widget.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({Key? key}) : super(key: key);

  @override
  State<CustomerLogin> createState() => _CustomerSignupState();
}

class _CustomerSignupState extends State<CustomerLogin> {
  late String email;
  late String password;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordvisible = false;



 

void logIn() async{
  setState(() {
    processing = true;
  });
   if (_formKey.currentState!.validate()) {
                             
                              try{
                                await FirebaseAuth.instance
                              .signInWithEmailAndPassword(email: email, password: password);
                            
                               _formKey.currentState!.reset();
                             
                              Navigator.pushReplacementNamed(context, '/customer_home');
                              } on FirebaseAuthException catch(e){
                                 if (e.code == 'user-not-found') {
                                  setState(() {
                                      processing = false;
                                   });
                                  MyMessageHandler.showSnackBar(
                                  _scaffoldKey, 'No user found for that email.');
                                       
                                       } else if (e.code == 'wrong-password') {
                                        setState(() {
                                      processing = false;
                                   });
                                        MyMessageHandler.showSnackBar(
                                  _scaffoldKey, 'Wrong password provided for that user.');
                                }
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: authenticationHeaderLabel(headerLabel: 'Log In'),
                      ),
                      const SizedBox(
                          height: 50,
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
                      TextButton(onPressed: (){}, child: const Text('Forgot Password ? ', 
                      style: TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                      )),
                      HaveAccount(
                        haveAccount: 'Don\'t Have Account? ',
                        actionLabel: 'Sign Up',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/customer_signup');
                        },
                      ),
                     processing ==true  
                     ? const Center (child:  CircularProgressIndicator())
                     : AuthenticationMainButton(
                        mainButtonLabel: 'Log In',
                        onPressed: (){
                          logIn();
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
