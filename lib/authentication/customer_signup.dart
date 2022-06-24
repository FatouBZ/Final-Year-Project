// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types

import 'package:flutter/material.dart';

import '../wigets/authentication_widget.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({Key? key}) : super(key: key);

  @override
  State<CustomerRegister> createState() => _CustomerSignupState();
}

class _CustomerSignupState extends State<CustomerRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: CircleAvatar(
                              radius: 60, backgroundColor: Colors.blue),
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
                                onPressed: () {},
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
                                onPressed: () {},
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
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Full Name',
                              hintText: 'Enter your full name')),
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
                      onPressed: () {},
                    ),
                    AuthenticationMainButton(
                      mainButtonLabel: 'Sign Up',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('valid');
                        } else {
                          print('not valid');
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

