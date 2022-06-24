import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/main_screen/supplier_home.dart';
import 'package:multi_store_app/wigets/Blue_Button.dart';

const textColors = [
  Color.fromARGB(255, 33, 212, 243),
  Colors.red,
  Color.fromARGB(255, 33, 243, 233),
  Color.fromARGB(255, 34, 44, 230),
];

const textStyle =
    TextStyle(fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'Acme');

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({Key? key}) : super(key: key);

  @override
  _WelcomScreenState createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/inapp/bg.jpeg'), fit: BoxFit.cover)),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedTextKit(animatedTexts: [
                ColorizeAnimatedText('WELCOME',
                    textStyle: textStyle, colors: textColors),
                ColorizeAnimatedText('EASY WAY',
                    textStyle: textStyle, colors: textColors),
              ]),
              const SizedBox(
                height: 120,
                width: 200,
                child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Image(
                        image: AssetImage('images/inapp/shopping-cart.png'),
                        color: Colors.grey)),
              ),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 45,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acme'),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Buy'),
                      RotateAnimatedText('Shop'),
                      RotateAnimatedText('Easy'),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Suppliers Only',
                            style: TextStyle(
                                color: Color.fromARGB(255, 82, 220, 255),
                                fontSize: 26,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedLogo(controller: _controller),
                              BlueButton(
                                  label: 'Log In',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/supplier—home');
                                  },
                                  width: 0.25),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: BlueButton(
                                    label: 'Sign Up',
                                    onPressed: () {},
                                    width: 0.25),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: BlueButton(
                                label: 'Log In',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/customer_home');
                                },
                                width: 0.25),
                          ),
                          BlueButton(
                              label: 'Sign Up',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/customer_signup');
                              },
                              width: 0.25),
                          AnimatedLogo(controller: _controller),
                        ],
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(38, 255, 255, 255)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GoogleFaceboobLogIn(
                        label: 'Google',
                        onPressed: () {},
                        child: const Image(
                            image: AssetImage('images/inapp/google.jpg')),
                      ),
                      GoogleFaceboobLogIn(
                        label: 'Facebook',
                        onPressed: () {},
                        child: const Image(
                            image: AssetImage('images/inapp/facebook.jpg')),
                      ),
                      GoogleFaceboobLogIn(
                          label: 'Guess',
                          onPressed: () {},
                          child: const Icon(
                            Icons.person,
                            size: 55,
                            color: Color.fromARGB(255, 33, 212, 243),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(
        image: AssetImage('images/inapp/shopping-cart.png'),
      ),
    );
  }
}

class GoogleFaceboobLogIn extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;
  const GoogleFaceboobLogIn({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
