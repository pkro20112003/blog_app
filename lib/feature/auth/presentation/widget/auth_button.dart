import 'package:flutter/material.dart';
import 'package:zidiointernshipblogapp/core/theme/app_pallete.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text("$buttonText"),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(395, 55),
        foregroundColor: AppPallete.gradient2,
      ),
    );
  }
}
