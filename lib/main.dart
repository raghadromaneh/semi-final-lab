import 'package:authandstore/screens/ResetPassword.dart';
import 'package:authandstore/screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/SignUp.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Ideal time to initialize

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      routes: {
        "/SignIn": (context) => SignIn(),
        "/SignUp": (context) => SignUp(),
        "/ResetPassword": (context) => ResetPassword(),
      },
    ),
  );
}
