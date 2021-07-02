import 'package:flutter/material.dart';

snackBar({required BuildContext context, required String title}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      duration: Duration(milliseconds: 600),
    ),
  );
}
