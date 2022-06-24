import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const BlueButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.30,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 212, 243),
          borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
