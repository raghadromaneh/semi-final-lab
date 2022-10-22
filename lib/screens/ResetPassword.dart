import 'package:authandstore/widgets/Button.dart';
import 'package:authandstore/widgets/TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

TextEditingController resetPassword = TextEditingController();

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: ListView(
          children: [
            Text(
              "Reset password",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Please enter your email address to recover your password.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            InputField(
              myController: resetPassword,
              HintText: "Enter your email",
              Security: false,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ButtonMain(
                OnPressing: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: resetPassword.text)
                      .then((value) => Navigator.of(context).pop());
                },
                ButtonTitle: "Reset Password",
              ),
            )
          ],
        ),
      )),
    );
  }
}
