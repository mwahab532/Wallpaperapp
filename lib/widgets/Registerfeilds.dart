import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Registerfeilds extends StatelessWidget {
  String hinttxt;
  bool isobscure;
  final TextStyle? txtsty;
  TextEditingController? controller;
  final validator;
  Registerfeilds({
    required this.hinttxt,
    required this.isobscure,
    this.controller,
    this.validator,
    this.txtsty,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: txtsty,
      obscureText: isobscure,
      cursorColor: Colors.black,
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
