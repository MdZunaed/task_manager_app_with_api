import 'package:flutter/material.dart';

class UiHelper {
  static showLoader(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
