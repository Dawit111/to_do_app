import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonTitle;
  VoidCallback onPressed;
  MyButton({super.key, required this.buttonTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.amber[300],
      child: Text(buttonTitle),
    );
  }
}
