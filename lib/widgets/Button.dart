import 'package:flutter/material.dart';

class ButtonMain extends StatelessWidget {
  ButtonMain({required this.OnPressing, this.ButtonTitle});
  Function() OnPressing;
  String? ButtonTitle;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 10, 87, 92),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      onPressed: OnPressing,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
        child: Text(
          "$ButtonTitle",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
