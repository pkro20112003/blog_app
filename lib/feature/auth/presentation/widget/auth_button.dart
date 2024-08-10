import 'package:flutter/material.dart';
import 'package:zidiointernshipblogapp/core/theme/app_pallete.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  const AuthButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text("$buttonText"),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(395, 55),
        foregroundColor: AppPallete.gradient2,
      ),
    );
  }
}
