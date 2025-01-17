import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Function()? onPressed;
  const FollowButton({super.key, required this.text, required this.backgroundColor, required this.borderColor,required this.textColor,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor)
        ),
        child: Center(child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(text,style: TextStyle(color: textColor),),
        ),),
      ),
    );
  }
}