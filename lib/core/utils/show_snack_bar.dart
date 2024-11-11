import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  final snackBar = SnackBar(
    content: Text(content),
    duration: Duration(seconds: 1),
  );

  // Hiển thị SnackBar
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
