import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zidiointernshipblogapp/core/common/widget/loader.dart';
import 'package:zidiointernshipblogapp/core/theme/app_pallete.dart';
import 'package:zidiointernshipblogapp/core/utils/Show_snackbar.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/pages/Signin_page.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/widget/auth_button.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/widget/auth_field.dart';
import 'package:zidiointernshipblogapp/feature/blog/presentation/pages/blog_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  ShowSnackBar(context, state.message);
                } else if (state is AuthSuccess) {
                  Navigator.pushAndRemoveUntil(
                      context, BlogPage.route(), (route) => false);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }
                return Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 70),
                      Text("Sign Up.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 15),
                      AuthField(hintText: "Name", controller: nameController),
                      const SizedBox(height: 15),
                      AuthField(
                        hintText: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      AuthField(
                        hintText: "Password",
                        controller: passwordController,
                        isObscureText: true,
                      ),
                      const SizedBox(height: 15),
                      AuthButton(
                        buttonText: "Sign Up",
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthSignUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim(),
                                ));
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                              text: "Already, have an account?",
                              children: [
                                TextSpan(
                                    text: " Sign In",
                                    style: TextStyle(
                                        color: AppPallete.blue,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
