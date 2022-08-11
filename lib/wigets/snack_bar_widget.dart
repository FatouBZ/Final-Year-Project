// ignore: file_names
import 'package:flutter/material.dart';

class MyMessageHandler {
  static void showSnackBar(var scaffoldKey, String message) {
    scaffoldKey.currentState!.hideCurrentSnackBar();
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(255, 33, 212, 243),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    ));
  }
}
  