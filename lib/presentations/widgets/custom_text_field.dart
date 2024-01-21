import 'package:flutter/material.dart';
class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key? key,
    required this.controller,
    required this.iconData,
    this.isobs = false,
    required this.title, required Color color,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData iconData;
  final String title;
  final bool isobs;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isobs,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        focusColor: Colors.black,
        hintText: title,
        hintStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}