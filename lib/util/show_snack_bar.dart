


import 'package:flutter/material.dart';

void showMessage(BuildContext context , String text){
  var snackbar = SnackBar(
    content: Text(
      text,
      style: TextStyle(
          fontFamily: 'dana', fontSize: 14),
    ),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context)
      .showSnackBar(snackbar);
}