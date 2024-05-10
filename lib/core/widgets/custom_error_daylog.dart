import 'package:flutter/material.dart';

ShowErrorDilog(BuildContext context, error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    margin: const EdgeInsets.all(10),
    behavior: SnackBarBehavior.floating,
    content: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Text(error),
    ),
  ));
}
