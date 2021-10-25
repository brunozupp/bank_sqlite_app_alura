import 'package:flutter/material.dart';

abstract class SnackbarUtils {

  static void showSnackbarError({
    required BuildContext context, 
    required String message
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
    ));
  }

  static void showSnackbarSuccess({
    required BuildContext context, 
    required String message
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
    ));
  }
}