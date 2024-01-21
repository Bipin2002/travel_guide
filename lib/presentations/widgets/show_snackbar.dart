import 'package:flutter/material.dart';

snowsnackBar({required BuildContext context, required Widget child}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: child));
}
