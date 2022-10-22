import 'package:authandstore/components/database.dart';
import 'package:authandstore/screens/userHome.dart';
import 'package:authandstore/screens/usersAdmin.dart';
import 'package:authandstore/services/firebaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _auth = FirebaseAuth.instance;
  final dbref = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset(
                "images/ltuc.png",
              ),
              const Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: InputField(
                  myController: Email,
                  HintText: "Enter your email",
                  Security: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: InputField(
                  myController: Password,
                  HintText: "Enter your password",
                  Security: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: GestureDetector(
                  onTap: () async {
                    await FirebaseServices().signInWithGoogle();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Welcome"),
                      ),
                    );

                    Database.userUid = FirebaseAuth.instance.currentUser?.uid;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Home();
                        },
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/gmail.png", scale: 20),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Sign in with Gmail",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/ResetPassword");
                    },
                    child: const Text(
                      "Reset password",
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 110,
                ),
                child: ButtonMain(
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
                      if (Email.toString().contains("@admin")) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ListOfUsers();
                            },
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UserHomePage();
                            },
                          ),
                        );
                      }
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
