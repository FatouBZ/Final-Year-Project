import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color:  Colors.pink,
          borderRadius: BorderRadius.circular(12)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
