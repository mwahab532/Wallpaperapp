import 'package:flutter/material.dart';

// ignore: must_be_immutable
class loginfeild extends StatelessWidget {
  String hinttxt;
  bool isobscure;
  TextEditingController? controller;
  final validator;
  loginfeild({
    required this.hinttxt,
    required this.isobscure,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: TextStyle(color: Colors.white),
      obscureText: isobscure,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hinttxt,
        hintStyle: TextStyle(
          fontSize: 13,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, strokeAlign: 10),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
