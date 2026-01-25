import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void ShowSnackBar(
  final BuildContext context, {
  required final String message,
  final Color color = Colors.red,
}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(backgroundColor: color, content: Text(message)));
}
