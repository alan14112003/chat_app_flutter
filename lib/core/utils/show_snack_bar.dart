import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  final snackBar = SnackBar(
    content: Text(content),
    duration: Duration(days: 1),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  // Hiển thị SnackBar
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
