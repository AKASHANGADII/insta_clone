

import 'package:flutter/material.dart';

class LogoutDailogButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color backgroundColor;

  const LogoutDailogButton({super.key, required this.text, this.onPressed, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
          child: Text(text),
        ),
      ),
      onTap:onPressed,
    );
  }
}