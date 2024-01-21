import 'package:flutter/material.dart';
class CustomField extends StatelessWidget {
  const CustomField(
      {Key? key,
      required this.controller,
      required this.title,
      this.htext = ''})
      : super(key: key);
  final TextEditingController controller;
  final String title;
  final String htext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: htext,
          helperStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: title,
          labelStyle: TextStyle(color: Colors.grey)),
    );
  }
}