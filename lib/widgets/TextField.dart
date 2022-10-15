// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({this.HintText, this.Security, required this.myController});
  String? HintText;
  bool? Security;
  TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 300),
      child: TextField(
        controller: myController,
        obscureText: Security!,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
            hintText: "$HintText",
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 119, 118, 118),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}
