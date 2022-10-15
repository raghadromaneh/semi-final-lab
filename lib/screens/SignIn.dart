import 'package:authandstore/components/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authandstore/widgets/TextField.dart';
import 'package:authandstore/widgets/Button.dart';
import 'package:authandstore/screens/home.dart';

class SignIn extends StatefulWidget {
  SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

TextEditingController Email = TextEditingController();
TextEditingController Password = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InputField(
                myController: Email,
                HintText: "Enter your email",
                Security: false,
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                myController: Password,
                HintText: "Enter your password",
                Security: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 35,
                  ),
                  const Text(
                    "don't have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 132, 131, 131),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/SignUp");
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 132, 131, 131),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonMain(
                OnPressing: () async {
                  try {
                    var authentacationObject = FirebaseAuth.instance;
                    UserCredential User =
                        await authentacationObject.signInWithEmailAndPassword(
                      email: Email.text,
                      password: Password.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Welcome"),
                      ),
                    );
                    Database.userUid = Email.text;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Home();
                      },
                    ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Incorrect password or email"),
                      ),
                    );
                  }
                },
                ButtonTitle: "Sign In",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
