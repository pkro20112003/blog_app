import 'package:flutter/material.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/widget/auth_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Sign Up.",
            style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        AuthField(hintText: "Name"),
        const SizedBox(height: 15),
        AuthField(hintText: "Email"),
        const SizedBox(height: 15),
        AuthField(hintText: "Password"),
      ],
    ));
  }
}
