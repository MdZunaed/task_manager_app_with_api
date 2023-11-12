import 'package:flutter/material.dart';

void showSnackMessage(context, String message, [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.green,
  ));
}
