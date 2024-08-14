import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zidiointernshipblogapp/core/theme/app_pallete.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/pages/signup_page.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/widget/auth_button.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/widget/auth_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 150),
            Text("Sign In",
                style: TextStyle(fontSize: 50, color: AppPallete.whiteColor)),
            const SizedBox(height: 15),
            AuthField(hintText: "Email id", controller: emailController),
            const SizedBox(height: 15),
            AuthField(
                hintText: "Password",
                controller: passwordController,
                isObscureText: true),
            const SizedBox(height: 15),
            AuthButton(buttonText: "Sign In", onPressed: () {}),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
              child: RichText(
                text: TextSpan(text: "Don't have an account?", children: [
                  TextSpan(
                    text: " Sign Up",
                    style: TextStyle(color: AppPallete.blue),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    )));
  }
}
