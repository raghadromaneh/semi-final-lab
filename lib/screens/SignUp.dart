import 'package:authandstore/screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authandstore/widgets/TextField.dart';
import 'package:authandstore/widgets/Button.dart';
import 'package:authandstore/screens/home.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Re_Password = TextEditingController();
  TextEditingController Username = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InputField(
              myController: Username,
              HintText: "Username",
              Security: false,
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              myController: Email,
              HintText: "Email",
              Security: false,
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              myController: PhoneNumber,
              HintText: "Phone Number",
              Security: false,
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              myController: Password,
              HintText: "Password",
              Security: true,
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              myController: Re_Password,
              HintText: "Password",
              Security: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                ButtonMain(
                  ButtonTitle: "Sign Up",
                  OnPressing: () async {
                    try {
                      var authentacationObject = FirebaseAuth.instance;
                      UserCredential User = await authentacationObject
                          .createUserWithEmailAndPassword(
                        email: Email.text,
                        password: Password.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Added Successfully"),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignIn();
                          },
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${e.toString()}"),
                        ),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
